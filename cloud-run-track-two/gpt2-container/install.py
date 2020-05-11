from transformers import GPT2LMHeadModel, GPT2Tokenizer 

GPT2LMHeadModel.from_pretrained("distilgpt2").save_pretrained("./model")
GPT2Tokenizer.from_pretrained("distilgpt2").save_pretrained("./tokenizer")
