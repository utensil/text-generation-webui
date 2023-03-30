#!/bin/bash

cd /app

set -euxo pipefail

set -x

# run outside
# cd installers/
# wget https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda-repo-debian11-11-7-local_11.7.1-515.65.01-1_amd64.deb

# auto-fix tokenizer name 
# can't prevent the first failure, 
# but will work the second time, because the first time the files are not downloaded yet
# https://github.com/oobabooga/text-generation-webui/issues/322
# ls -1 models/**/tokenizer_config.json|xargs sed -i -e 's/LLaMATokenizer/LlamaTokenizer/g'

# FAIL! RuntimeError: probability tensor contains either `inf`, `nan` or element < 0
# rwkv 14b 8bit with cpu offloading
# python server.py --cai-chat --listen --listen-port=8888 --model=RWKV-4b-Pile-1B5-20230217-7954.pth --rwkv-cuda-on --rwkv-strategy="cuda fp16i8 *25 -> cpu fp32"

# WORKS but stupid
# python server.py --cai-chat --listen --listen-port=8888 --model=RWKV-4b-Pile-1B5-20230217-7954.pth --rwkv-strategy "cpu fp32"

# FAIL! OOM Killed 
# python server.py --cai-chat --listen --listen-port=8888 --model=RWKV-4-Pile-7B-20230313-ctx8192-test380.pth --rwkv-strategy "cpu fp32"

# FAIL! RuntimeError: "LayerNormKernelImpl" not implemented for 'Half'
# python server.py --cai-chat --listen --listen-port=8888 --model=RWKV-4-Pile-7B-20230313-ctx8192-test380.pth --rwkv-strategy "cpu fp16"

# FAIL! torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 64.00 MiB (GPU 0; 8.00 GiB total capacity; 6.31 GiB already allocated; 85.54 MiB free; 6.37 GiB reserved in total by PyTorch) If reserved memory is >> allocated memory try setting max_split_size_mb to avoid fragmentation.  See documentation for Memory Management and PYTORCH_CUDA_ALLOC_CONF
# python server.py --cai-chat --listen --listen-port=8888 --model=RWKV-4-Pile-7B-20230313-ctx8192-test380.pth --rwkv-strategy "cuda fp16i8"

# WORKS but extremely silly and knows nothing
# python server.py --cai-chat --listen --listen-port=8888 --model=RWKV-4-Pile-7B-20230313-ctx8192-test380.pth --rwkv-strategy "cuda fp16i8 *10 -> cpu fp32"

# WORKS but silly and pretend to know things
# python server.py --cai-chat --listen --listen-port=8888 --model=RWKV-4-Pile-7B-Instruct-test4-20230326.pth --rwkv-strategy "cuda fp16i8 *10 -> cpu fp32"

# FAIL!
# torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 44.00 MiB (GPU 0; 8.00 GiB total capacity; 6.13 GiB already allocated; 71.54 MiB free; 6.38 GiB reserved in total by PyTorch)
# python server.py --load-in-8bit --model llama-7b-hf --cai-chat --listen --listen-port=8888

# WORKS on startup FAILS during inference
# torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 192.00 MiB (GPU 0; 8.00 GiB total capacity; 5.66 GiB already allocated; 135.54 MiB free; 6.11 GiB reserved in total by PyTorch)
# python server.py --auto-devices --gpu-memory 5 --load-in-8bit --model llama-7b-hf --cai-chat --listen --listen-port=8888

# WORKS but NOT GREAT
# python server.py --auto-devices --gpu-memory 3 --load-in-8bit --model llama-7b-hf --cai-chat --listen --listen-port=8888

# WORKS but neither great or fast
# Output generated in 20.11 seconds (0.45 tokens/s, 9 tokens, context 40)
# Output generated in 99.46 seconds (0.46 tokens/s, 46 tokens, context 59)
# Output generated in 67.72 seconds (0.46 tokens/s, 31 tokens, context 114)
# Output generated in 124.30 seconds (0.46 tokens/s, 57 tokens, context 171)
# Output generated in 218.03 seconds (0.46 tokens/s, 101 tokens, context 250)
# python server.py --auto-devices --gpu-memory 5 --model llama-7b-hf --lora alpaca-lora-7b --cai-chat --listen --listen-port=8888

# FAILED! deepspeed not installed
# pip install deepspeed==0.8.3
# FAIL!
# RuntimeError: size mismatch, got 41, 41x4096,0
# deepspeed --num_gpus=1 server.py --deepspeed --model llama-7b-hf --lora alpaca-lora-7b --gpu-memory 5 --load-in-8bit --cai-chat --listen --listen-port=8888
# FAIL!
# deepspeed --num_gpus=1 server.py --deepspeed --model llama-7b-hf --lora alpaca-lora-7b --gpu-memory 5 --cai-chat --listen --listen-port=8888


# alpaca-native-4bit
# FAIL!
# ModuleNotFoundError: No module named 'llama'
# python server.py --model alpaca-native-4bit --model_type llama --wbits 4 --groupsize 128

# install LLAMA GPTQ
# mkdir -p /app/repositories/
# cd /app/repositories/
# if [ ! -d "/app/repositories/GPTQ-for-LLaMa" ]; then
#     git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa
# fi
# cd /app/repositories/GPTQ-for-LLaMa/ && python setup_cuda.py install > /dev/null 2>&1 && cd /app

# FAIL!
# Could not find the quantized model in .pt or .safetensors format, exiting..
# python server.py --model alpaca-native-4bit --model_type llama --wbits 4 --groupsize 128
# NOTE do this outside:
# python download-model.py ozcur/alpaca-native-4bit
# WORK! GREAT and FAST
# Output generated in 3.46 seconds (4.05 tokens/s, 14 tokens, context 41)
# Output generated in 5.48 seconds (8.39 tokens/s, 46 tokens, context 66)
# Output generated in 6.70 seconds (5.53 tokens/s, 37 tokens, context 124)
# Output generated in 3.03 seconds (3.96 tokens/s, 12 tokens, context 183)
# Output generated in 4.33 seconds (7.16 tokens/s, 31 tokens, context 208)
# Output generated in 5.14 seconds (7.98 tokens/s, 41 tokens, context 250)
# Output generated in 5.14 seconds (7.39 tokens/s, 38 tokens, context 317)
# Output generated in 11.61 seconds (9.73 tokens/s, 113 tokens, context 380)
# Output generated in 7.10 seconds (7.74 tokens/s, 55 tokens, context 517)
# Output generated in 5.33 seconds (5.82 tokens/s, 31 tokens, context 589)
# Output generated in 12.81 seconds (8.82 tokens/s, 113 tokens, context 646)
# Output generated in 5.85 seconds (5.81 tokens/s, 34 tokens, context 786)
# Output generated in 3.80 seconds (2.37 tokens/s, 9 tokens, context 834)
# Output generated in 4.56 seconds (2.63 tokens/s, 12 tokens, context 855)
# Output generated in 3.36 seconds (0.89 tokens/s, 3 tokens, context 884)
# Output generated in 3.60 seconds (1.11 tokens/s, 4 tokens, context 912)
# Output generated in 4.27 seconds (0.94 tokens/s, 4 tokens, context 945)
# Output generated in 4.28 seconds (0.93 tokens/s, 4 tokens, context 981)
# Output generated in 6.82 seconds (5.57 tokens/s, 38 tokens, context 994)
# Output generated in 7.67 seconds (5.74 tokens/s, 44 tokens, context 1064)
# python server.py --model alpaca-native-4bit --model_type llama --wbits 4 --groupsize 128 --cai-chat --listen --listen-port=8888

# WORKS seems know more, need more test, slower than --model llama-7b-hf --cpu --lora alpaca-lora-7b
# Output generated in 36.18 seconds (0.41 tokens/s, 15 tokens, context 42)
# Output generated in 160.09 seconds (0.47 tokens/s, 75 tokens, context 70)
# Output generated in 105.06 seconds (0.47 tokens/s, 49 tokens, context 157)
# Output generated in 71.79 seconds (0.47 tokens/s, 34 tokens, context 223)
# python server.py --auto-devices --gpu-memory 5 --model alpaca-native --model_type llama --cai-chat --listen --listen-port=8888

# WORKS seem better, same speed as --model llama-7b-hf --cpu --lora alpaca-lora-7b
# python server.py --cpu --model alpaca-native --model_type llama --cai-chat --listen --listen-port=8888

# https://github.com/oobabooga/text-generation-webui/pull/366
# https://github.com/oobabooga/text-generation-webui/wiki/Using-LoRAs
# https://github.com/oobabooga/text-generation-webui/issues/332#issuecomment-1483734194
# alpaca-lora-7b

# FAIL!
# torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 44.00 MiB (GPU 0; 8.00 GiB total capacity; 6.13 GiB already allocated; 71.54 MiB free; 6.38 GiB reserved in total by PyTorch)
# python server.py --load-in-8bit --model llama-7b-hf --lora alpaca-lora-7b --cai-chat --listen --listen-port=8888

# FAIL!
# TypeError: Linear.__init__() got an unexpected keyword argument 'has_fp16_weights'
# python server.py  --auto-devices --gpu-memory 5 --load-in-8bit --model llama-7b-hf --lora alpaca-lora-7b --cai-chat --listen --listen-port=8888

# WORKS! 1st success, baseline performance, quite acceptable
# Output generated in 11.05 seconds (1.45 tokens/s, 16 tokens, context 40)
# Output generated in 32.67 seconds (1.62 tokens/s, 53 tokens, context 66)
# Output generated in 29.53 seconds (1.49 tokens/s, 44 tokens, context 128)
# python server.py --model llama-7b-hf --cpu --lora alpaca-lora-7b --cai-chat --listen --listen-port=8888

# WORKS！but slow CN
# python server.py --model llama-7b-hf --cpu --lora alpaca-lora-7b-zh-en --cai-chat --listen --listen-port=8888

# WORKS! but not so smart CN
#   warnings.warn(
# Output generated in 15.71 seconds (1.53 tokens/s, 24 tokens, context 48)
# Output generated in 30.57 seconds (1.60 tokens/s, 49 tokens, context 87)
# Output generated in 52.95 seconds (1.61 tokens/s, 85 tokens, context 153)
# Output generated in 31.86 seconds (1.32 tokens/s, 42 tokens, context 273)
# Output generated in 81.15 seconds (1.02 tokens/s, 83 tokens, context 989)
# python server.py --cpu --model llama-7b-hf --lora luotuo-lora-7b-0.3 --cai-chat --listen --listen-port=8888

# WORKS! seems smarter than 16bit CN, and normal speed
# Output generated in 144.45 seconds (1.38 tokens/s, 199 tokens, context 702)
# Output generated in 74.18 seconds (1.01 tokens/s, 75 tokens, context 918)
# Output generated in 95.42 seconds (1.08 tokens/s, 103 tokens, context 1009)
# Output generated in 68.53 seconds (0.79 tokens/s, 54 tokens, context 1142)
# Output generated in 146.86 seconds (1.12 tokens/s, 164 tokens, context 1263)
# Output generated in 58.78 seconds (0.41 tokens/s, 24 tokens, context 1453)
#python server.py --cpu --model llama-7b-hf --lora luotuo-lora-7b-0.3 --load-in-8bit --cai-chat --listen --listen-port=8888

# FAIL! ValueError: Loading models/chatglm-6b requires you to execute the configuration file in that repo on your local machine. Make sure you have read the code there to avoid malicious use, then set the option `trust_remote_code=True` to remove this error.
# FAIL! ImportError: This modeling file requires the following packages that were not found in your environment: icetk. Run `pip install icetk`
# pip install icetk
# FAIL! RuntimeError: mixed dtype (CPU): expect input to have scalar type of BFloat16
# WORKS! 
# Output generated in 33.75 seconds (0.86 tokens/s, 29 tokens, context 39)
# Output generated in 145.04 seconds (1.37 tokens/s, 199 tokens, context 72)
# Input length of input_ids is 353, but `max_length` is set to 200. This can lead to unexpected behavior. You should consider increasing `max_new_tokens`.
# Output generated in 129.36 seconds (1.54 tokens/s, 199 tokens, context 353)
# Input length of input_ids is 569, but `max_length` is set to 200. This can lead to unexpected behavior. You should consider increasing `max_new_tokens`.
# Output generated in 147.52 seconds (1.35 tokens/s, 199 tokens, context 569)
# python server.py --cpu --model chatglm-6b --cai-chat --listen --listen-port=8888
# FAIL! torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 96.00 MiB (GPU 0; 8.00 GiB total capacity; 6.40 GiB already allocated; 57.54 MiB free; 6.40 GiB reserved in total by PyTorch) If reserved memory is >> allocated memory try setting max_split_size_mb to avoid fragmentation.  See documentation for Memory Management and PYTORCH_CUDA_ALLOC_CONF
# python server.py --model chatglm-6b --cai-chat --listen --listen-port=8888

# FAIL!
# TypeError: Linear.__init__() got an unexpected keyword argument 'has_fp16_weights'
# python server.py --model llama-7b-hf --lora alpaca-lora-7b-zh-en --auto-devices --gpu-memory 5 --load-in-8bit --cai-chat --listen --listen-port=8888

# WORKS but WORSE
# python server.py --model llama-7b-hf --lora alpaca-lora-7b-zh-en --auto-devices --gpu-memory 5 --cai-chat --listen --listen-port=8888

# TRAINING Section

# FAIL! torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 172.00 MiB (GPU 0; 8.00 GiB total capacity; 6.38 GiB already allocated; 71.54 MiB free; 6.38 GiB reserved in total by PyTorch) 
# python server.py --cpu --model llama-7b-hf --load-in-8bit --cai-chat --listen --listen-port=8888

# FAIL! TypeError: Linear.__init__() got an unexpected keyword argument 'has_fp16_weights'
# python server.py  --auto-devices --gpu-memory 5 --model llama-7b-hf --load-in-8bit --cai-chat --listen --listen-port=8888

# FAIL! NotImplementedError: Cannot copy out of meta tensor; no data!
# python server.py  --auto-devices --gpu-memory 4 --model llama-7b-hf --cai-chat --listen --listen-port=8888

python server.py --model llama-7b --load-in-8bit

# UNTESTED Section

# llama-13b-4bit
# python server.py --load-in-4bit --model llama-13b-hf --cai-chat --listen --listen-port=8888

# llama-30b-4bit
# python server.py --auto-devices --gpu-memory 10 --load-in-4bit --model llama-30b-hf --cai-chat --listen --listen-port=8888

# OPT-13B-Erebus
# python server.py --auto-devices --gpu-memory 10 --cai-chat --bf16 --listen --listen-port=8888 --model=OPT-13B-Erebus

# GPT-NeoXT-Chat-Base-20B 8bit
# python server.py --auto-devices --gpu-memory 8 --cai-chat --load-in-8bit --listen --listen-port 8888 --model=GPT-NeoXT-Chat-Base-20B

# deepspeed --num_gpus=1 server.py --deepspeed --gpu-memory 10 --cai-chat --model=pygmalion-6b

# pygmalion-6b bf16
# python server.py --auto-devices --gpu-memory 10 --cai-chat --bf16 --listen --listen-port=8888 --model=pygmalion-6b

# pygmalion-6b 8bit
# python server.py --auto-devices --gpu-memory 10 --cai-chat --load-in-8bit --listen --listen-port=8888 --model=pygmalion-6b

# llama-7b-8bit
# https://github.com/oobabooga/text-generation-webui/issues/517