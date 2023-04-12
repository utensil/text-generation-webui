#!/bin/bash

cd $APP

set -euxo pipefail

set -x

ln -s $HOME/.cache/models/ $APP/models/ && ln -s $HOME/.cache/loras/ $APP/loras/

python3 download-model.py decapoda-research/llama-7b-hf --threads 16

ls -1 models/**/tokenizer_config.json|xargs sed -i -e 's/LLaMATokenizer/LlamaTokenizer/g'

# For A10G large
# --model decapoda-research_llama-7b-hf --listen --chat
# For low VRAM
# --model decapoda-research_llama-7b-hf --auto-devices --listen --chat

python3 download-model.py chavinlo/alpaca-native --threads 16

# --model chavinlo_alpaca-native --auto-devices --listen --chat --cpu
