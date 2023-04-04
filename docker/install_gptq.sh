#!/bin/bash

set -euxo pipefail

set -x

# install LLAMA GPTQ
mkdir -p repositories
cd repositories
if [ ! -d "GPTQ-for-LLaMa" ]; then
    git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa
fi
cd GPTQ-for-LLaMa && pip install -r requirements.txt
