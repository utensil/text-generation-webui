import subprocess

subprocess.run(f"bash ./docker/install_gptq.sh", shell=True, check=True)

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

subprocess.run(f"python download-model.py anon8231489123/vicuna-13b-GPTQ-4bit-128g", shell=True, check=True)

subprocess.run(f"python server.py --auto-devices --gpu-memory 22 --model anon8231489123_vicuna-13b-GPTQ-4bit-128g --model_type llama --cai-chat --wbits 4 --groupsize 128", shell=True, check=True)
