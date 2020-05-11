# Copyright 2019 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import torch
import torch.nn.functional as F
from transformers import GPT2LMHeadModel, GPT2Tokenizer 
from flask import Flask, request
import os
import random
from profanity_filter import ProfanityFilter 
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

class Predictor:

    def __init__(self):
        self.model = GPT2LMHeadModel.from_pretrained("./model")
        self.model.eval()
        self.tokenizer = GPT2Tokenizer.from_pretrained("./tokenizer")

        # If you change the seed, perform a lot of testing, because
        # it has a strong influence on the quality of the bot. 
        self.seed = self.tokenizer.encode("\n".join([
            "You: \"Hello, it's so nice to meet you!\"",
            "Charles: \"Nice to meet you too! I am a software engineer developing applications with Cloud Run.\"",
            "You: \"That's great! I am an engineer too!\"",
            "Charles: \"I am a GPT-2 chatbot. What's your job?\"",
            "You: \"I am a developer writing software.\"",
            "Charles: \"I like arcades. What is your favorite game?\"",
            "You: \"I'm not really into arcades, sorry.\"",
            "Charles: \"How old are you?\"",
            "You: \"My age is 31\"",
            "Charles: \"What pets do you like? Cats or dogs?\"",
            "You: \"Cats, definitely cats.\"",
            "Charles: \"Do you like Google Cloud?\"",
            "You: \"Yes, I do!\"",
            "Charles: \"Let's talk programming languages.\"",
            "You: \"That's a great topic.\"",
            "Charles: \"What do you think about Node.js?\"",
            "You: \"I think it's great!\"",
            "Charles: \"Are you also an engineer?\"",
            "You: \"Yes, I am\"",
            "Charles: \"What is your name?\"", 
            "You: \"I can't tell you that.\""]))
 
    def next_token(self, indexed_tokens):         
        input_ids = torch.tensor([indexed_tokens], device="cpu")
        input_ids.to("cpu")
        
        with torch.no_grad():
            outputs = self.model(input_ids)
            next_token_logits = outputs[0][0, -1, :] 
            
            sorted_logits, sorted_indices = torch.sort(next_token_logits, descending=True)
            cumulative_probs = torch.cumsum(F.softmax(sorted_logits, dim=-1), dim=-1)
            sorted_indices_to_remove = cumulative_probs > 0.91
            sorted_indices_to_remove[..., 1:] = sorted_indices_to_remove[..., :-1].clone()
            sorted_indices_to_remove[..., 0] = 0
            indices_to_remove = sorted_indices[sorted_indices_to_remove]
            next_token_logits[indices_to_remove] = -float('Inf')
            
        next_token = torch.multinomial(F.softmax(next_token_logits, dim=-1), num_samples=1).item()        
        return next_token

    def sentence( self, prompt ):
        # Tokenize the prompt and start generating new tokens
        # that complete the prompt.
        prompt = self.tokenizer.encode(prompt)
        reply = []
        
        # Limit the length of generated sentences. 
        tokenCountMax = 25

        lastTokens = [            
            self.tokenizer.encode("\"")[0],
            self.tokenizer.encode("?\"")[0],
            self.tokenizer.encode("!\"")[0],
            self.tokenizer.encode(".\"")[0],            
        ]
        
        for tokenCount in range(tokenCountMax):
            # Sometimes GPT-2 does not want to stop talking
            if tokenCount == tokenCountMax-1:                
                return None
    
            token = self.next_token(self.seed + prompt + reply)
            # When end of sentence (EOS) is generated, append " and stop
            if token == self.tokenizer.eos_token_id: 
                reply.apppend(self.tokenizer.encode("\"")[0])
                break            

            reply.append(token)

            # When the last token is ", ?", !", or .", stop. 
            if token in lastTokens: break
          
        return self.tokenizer.decode(reply).strip()        

class Chat: 
  def __init__(self ):         
    self.predictor = Predictor()

    # Use a fixed set of first responses to start the conversation
    # more naturally. 
    self.intros = [
        "Hi, what's your name?",
        "Hey, you're back! Nice to see you again!",
        "Hi what's up?",
        "What brings you here?",
        "Hey there, how are you doing?",
        "Ola!",
        "Hi!",
        "Hello, thanks for visiting me!",
        "Nice to meet you, what do you want to talk about?",
    ]
    self.text = ""
       
  def _add_prompt(self, prompt):
    self.text = self.text + "\nYou: \"" + pf.censor(prompt) + "\""
  
  def _add_reply(self, reply):
    self.text = self.text + "\nCharles: \"" + pf.censor(reply) + "\""

  def _generate_reply(self):
    reply = None  

    for _ in range(5):
        reply = self.predictor.sentence(self.text + "\nCharles: \"")
        if reply == None: continue  

        # Do sentiment analysis because sometimes this bot
        # will randomly get in a very bad mood and say "I'm going to kill you!"
        sentiment = sid.polarity_scores(reply)["compound"]
        if sentiment > -0.05:  
            break
        else:
            print("Rejected for negativity: \"", reply)
            
    if reply == None:
        reply = "I am not sure what to say now."
    else:
        reply = pf.censor(reply.replace("\"", ''))
    return reply

  def say(self, prompt):
    if self.text == "":
        self._add_prompt(prompt)               
        reply = random.choice(self.intros)
        self._add_reply(reply)
        return reply
    
    self._add_prompt(prompt)        
    reply = self._generate_reply()
    self._add_reply(reply)
    return reply

chat = Chat()
app = Flask(__name__)
pf = ProfanityFilter()
sid = SentimentIntensityAnalyzer()

@app.route('/', methods = ['POST'])
def hello():    
    return chat.say(request.get_data().decode("utf-8").strip())+"\n"

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8080))
    app.run(host='0.0.0.0', port=port)