#!/bin/bash

cd $APP

set -euxo pipefail

set -x

ln -s $HOME/.cache/models/ $APP/models/ && ln -s $HOME/.cache/loras/ $APP/loras/

python3 download-model.py decapoda-research/llama-7b-hf --threads 16

ls -1 models/**/tokenizer_config.json|xargs sed -i -e 's/LLaMATokenizer/LlamaTokenizer/g'
