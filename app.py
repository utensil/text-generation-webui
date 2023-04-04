import subprocess

subprocess.run(f"bash ./docker/install_gptq.sh", shell=True, check=True)

subprocess.run(f"python download-model.py chavinlo/alpaca-native", shell=True, check=True)

subprocess.run(f"python server.py --cpu --model chavinlo_alpaca-native --model_type llama --cai-chat", shell=True, check=True)