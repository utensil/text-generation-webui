#!/bin/bash

cd /app

set -euxo pipefail

set -x

# install LLAMA GPTQ
cd /app/repositories/GPTQ-for-LLaMa/ && python setup_cuda.py install > /dev/null 2>&1 && cd /app

# deepspeed --num_gpus=1 server.py --deepspeed --gpu-memory 10 --cai-chat --model=pygmalion-6b

# rwkv 14b 8bit with cpu offloading
# python server.py --cai-chat --listen --listen-port=8888 --model=RWKV-4-Pile-14B-20230228-ctx4096-test663.pth --rwkv-cuda-on --rwkv-strategy="cuda fp16i8 *25 -> cpu fp32"

# pygmalion-6b bf16
# python server.py --auto-devices --gpu-memory 10 --cai-chat --bf16 --listen --listen-port=8888 --model=pygmalion-6b

# pygmalion-6b 8bit
# python server.py --auto-devices --gpu-memory 10 --cai-chat --load-in-8bit --listen --listen-port=8888 --model=pygmalion-6b

# llama-13b-4bit
# python server.py --load-in-4bit --model llama-13b-hf --cai-chat --listen --listen-port=8888

# llama-30b-4bit
# python server.py --auto-devices --gpu-memory 10 --load-in-4bit --model llama-30b-hf --cai-chat --listen --listen-port=8888

# OPT-13B-Erebus
# python server.py --auto-devices --gpu-memory 10 --cai-chat --bf16 --listen --listen-port=8888 --model=OPT-13B-Erebus

# GPT-NeoXT-Chat-Base-20B 8bit
# python server.py --auto-devices --gpu-memory 8 --cai-chat --load-in-8bit --listen --listen-port 8888 --model=GPT-NeoXT-Chat-Base-20B