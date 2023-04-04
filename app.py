import subprocess

subprocess.run(f"bash ./docker/install_gptq.sh", shell=True, check=True)

subprocess.run(f"python download-model.py chavinlo/alpaca-native", shell=True, check=True)

# 8 vCPU 32 GB RAM
# Output generated in 445.08 seconds (0.17 tokens/s, 76 tokens, context 46)
# subprocess.run(f"python server.py --cpu --model chavinlo_alpaca-native --model_type llama --cai-chat", shell=True, check=True)

# Nvidia A10G small
# 4 vCPU 15 GB RAM 24GB VRAM
# Memory limit exceeded (14Gi)
# subprocess.run(f"python server.py --model chavinlo_alpaca-native --model_type llama --cai-chat", shell=True, check=True)

# Nvidia A10G small
# 4 vCPU 15 GB RAM 24GB VRAM
# Memory limit exceeded (14Gi)
subprocess.run(f"python server.py --auto-devices --gpu-memory 22 --model chavinlo_alpaca-native --model_type llama --cai-chat", shell=True, check=True)
