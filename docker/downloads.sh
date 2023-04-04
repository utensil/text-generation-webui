# run `./docker/downloads.sh` from the root of the repository

python download-model.py decapoda-research/llama-7b-hf

python download-model.py tloen/alpaca-lora-7b

python download-model.py chavinlo/alpaca-native

python download-model.py THUDM/chatglm-6b

python download-model.py ozcur/alpaca-native-4bit

python download-model.py Chris-zhp/alpaca-lora-7b-zh-en

python download-model.py silk-road/luotuo-lora-7b-1.0

python download-model.py PygmalionAI/pygmalion-6b

python download-model.py facebook/galactica-120b

python download-model.py nomic-ai/gpt4all-lora

python download-model.py cerebras/Cerebras-GPT-13B
python download-model.py chavinlo/gpt4-x-alpaca
python download-model.py chavinlo/toolpaca
python download-model.py KBlueLeaf/guanaco-7B-leh
python download-model.py JosephusCheung/GuanacoLatest
python download-model.py ziqingyang/chinese-llama-lora-7b
python download-model.py ziqingyang/chinese-alpaca-lora-7b

# TOO BIG and not needed
# python download-model.py BlinkDL/rwkv-4-pile-7b

# aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/BlinkDL/rwkv-4-pile-7b/resolve/main/RWKV-4-Pile-7B-20230313-ctx8192-test380.pth -d models -o RWKV-4-Pile-7B-20230313-ctx8192-test380.pth

# aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/BlinkDL/rwkv-4-pile-7b/resolve/main/RWKV-4-Pile-7B-Instruct-test4-20230326.pth -d models -o RWKV-4-Pile-7B-Instruct-test4-20230326.pth