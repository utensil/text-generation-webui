#!/bin/bash

set -euxo pipefail

set -x

# install LLAMA GPTQ
mkdir -p repositories
cd repositories
if [ ! -d "GPTQ-for-LLaMa" ]; then
    pip uninstall quant-cuda
    git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda
fi

cd GPTQ-for-LLaMa

pip install -r requirements.txt

if [ -z ${CUDA_HOME+x} ]; then
    echo "Missing CUDA"
else
    python setup_cuda.py install
fi