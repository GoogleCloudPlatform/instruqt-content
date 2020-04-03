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

FROM debian:buster-slim as base

FROM base as builder

# Install conda
RUN apt-get -qq update && apt-get -qq -y install curl bzip2 
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh 
RUN bash /tmp/miniconda.sh -bfp /usr/local 
RUN rm -rf /tmp/miniconda.sh 

RUN conda install -y python=3 
RUN conda update conda 

# Install dependencies
RUN conda install numpy -c conda-forge -y
RUN conda install cpuonly pytorch -c pytorch -y
# Conda lets you install pytorch without CUDA support (cpuonly).
# CUDA makes the library very large and we don't have a GPU anyway.

# Remove static libraries and python byte code
RUN find / -iname "*.a" -delete 
RUN find / -iname "*.pyc" -delete

COPY requirements.txt /requirements.txt
RUN pip install --user -r /requirements.txt

# Clean up conda packages
RUN conda clean --all --yes

FROM base 

# Saving memory on Cloud Run, don't write byte code to file 
ENV PYTHONDONTWRITEBYTECODE=true

COPY --from=builder /usr/local /usr/local

RUN groupadd -r app
RUN useradd -rmg app app
WORKDIR /home/app
USER app
COPY --from=builder --chown=app:app /root/.local /home/app/.local

RUN python -m spacy download en

# Download GPT-2 model
COPY install.py .
RUN mkdir model tokenizer && python install.py 

COPY server.py .
CMD ["python3", "server.py"]