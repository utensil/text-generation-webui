import subprocess

# subprocess.run(f"python download-model.py chavinlo/alpaca-native", shell=True, check=True)

# 8 vCPU 32 GB RAM
# Output generated in 445.08 seconds (0.17 tokens/s, 76 tokens, context 46)
# subprocess.run(f"python server.py --cpu --model chavinlo_alpaca-native --model_type llama --cai-chat", shell=True, check=True)

# Nvidia A10G small
# 4 vCPU 15 GB RAM 24GB VRAM
# Memory limit exceeded (14Gi)
# subprocess.run(f"python server.py --model chavinlo_alpaca-native --model_type llama --cai-chat", shell=True, check=True)

# Nvidia A10G small
# 4 vCPU 15 GB RAM 24GB VRAM
# Output generated in 3.11 seconds (5.46 tokens/s, 17 tokens, context 47)
# Output generated in 7.01 seconds (13.26 tokens/s, 93 tokens, context 75)
# Output generated in 3.78 seconds (13.77 tokens/s, 52 tokens, context 180)
# Output generated in 4.23 seconds (13.70 tokens/s, 58 tokens, context 254)
# Output generated in 4.33 seconds (13.85 tokens/s, 60 tokens, context 325)
# Output generated in 5.20 seconds (13.08 tokens/s, 68 tokens, context 403)
# Output generated in 2.58 seconds (11.99 tokens/s, 31 tokens, context 492)
# Output generated in 1.63 seconds (9.80 tokens/s, 16 tokens, context 545)
# Fast and normal response, but not aware of context
# subprocess.run(f"python server.py --auto-devices --gpu-memory 22 --model chavinlo_alpaca-native --model_type llama --cai-chat", shell=True, check=True)

# subprocess.run(f"python server.py --auto-devices --gpu-memory 22 --model chavinlo_alpaca-native --model_type llama --cai-chat", shell=True, check=True)

subprocess.run(f"bash ./docker/install_gptq.sh", shell=True, check=True)

# subprocess.run(f"python download-model.py anon8231489123/vicuna-13b-GPTQ-4bit-128g", shell=True, check=True)
# FAST humor answers but not much sense
# Output generated in 22.55 seconds (8.82 tokens/s, 199 tokens, context 43)
# Output generated in 21.36 seconds (9.32 tokens/s, 199 tokens, context 265)
# Output generated in 3.30 seconds (7.26 tokens/s, 24 tokens, context 474)
# Output generated in 22.14 seconds (8.99 tokens/s, 199 tokens, context 512)
# Output generated in 24.90 seconds (7.99 tokens/s, 199 tokens, context 722)
# Output generated in 22.99 seconds (8.65 tokens/s, 199 tokens, context 942)
# Output generated in 23.54 seconds (8.45 tokens/s, 199 tokens, context 1159)
# Output generated in 24.10 seconds (8.26 tokens/s, 199 tokens, context 1382)
# Output generated in 3.88 seconds (8.25 tokens/s, 32 tokens, context 379)
# Output generated in 3.15 seconds (7.29 tokens/s, 23 tokens, context 422)
# Output generated in 3.94 seconds (7.87 tokens/s, 31 tokens, context 460)
# Output generated in 2.65 seconds (6.40 tokens/s, 17 tokens, context 499)
# Output generated in 4.68 seconds (8.12 tokens/s, 38 tokens, context 528)
# Output generated in 3.69 seconds (7.32 tokens/s, 27 tokens, context 574)
# Output generated in 24.61 seconds (8.09 tokens/s, 199 tokens, context 1603)
# subprocess.run(f"python server.py --auto-devices --gpu-memory 22 --model anon8231489123_vicuna-13b-GPTQ-4bit-128g --model_type llama --cai-chat --wbits 4 --groupsize 128", shell=True, check=True)

# subprocess.run(f"python download-model.py decapoda-research/llama-7b-hf", shell=True, check=True)

# subprocess.run(f"bash ./docker/fix_llama.sh", shell=True, check=True)

# subprocess.run(f"python server.py --auto-devices --gpu-memory 22 --model decapoda-research_llama-7b-hf --model_type llama --load-in-8bit --cai-chat", shell=True, check=True)

subprocess.run(f"python download-model.py TheBloke/galpaca-30B-GPTQ-4bit-128g", shell=True, check=True)

subprocess.run(f"mv models/TheBloke_galpaca-30B-GPTQ-4bit-128g/galpaca-30B-4bit-128g.no-act-order.pt models/TheBloke_galpaca-30B-GPTQ-4bit-128g/TheBloke_galpaca-30B-GPTQ-4bit-128g-4bit.pt", shell=True, check=True)

subprocess.run(f"python server.py --auto-devices --gpu-memory 22 --model TheBloke_galpaca-30B-GPTQ-4bit-128g --wbits 4 --groupsize 128 --chat", shell=True, check=True)

# subprocess.run(f"pip install deepspeed==0.8.3", shell=True, check=True)

# subprocess.run(f"deepspeed --num_gpus=1 server.py --model decapoda-research_llama-7b-hf --model_type llama --cai-chat --deepspeed", shell=True, check=True)
