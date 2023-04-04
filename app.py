import subprocess



subprocess.run(f"bash ./docker/install_gptq.sh", shell=True, check=True)

subprocess.run(f"python download-model.py ozcur/alpaca-native-4bit", shell=True, check=True)

subprocess.run(f"python server.py --model alpaca-native-4bit --model_type llama --wbits 4 --groupsize 128 --cai-chat", shell=True, check=True)