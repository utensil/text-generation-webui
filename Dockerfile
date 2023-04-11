# FROM nvidia/cuda:11.7.1-devel-ubuntu22.04 as builder

# RUN apt-get update && \
#     apt-get install --no-install-recommends -y git vim build-essential python3-dev python3-venv && \
#     rm -rf /var/lib/apt/lists/*

# RUN git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa /build

# WORKDIR /build

# RUN python3 -m venv /build/venv
# RUN . /build/venv/bin/activate && \
#     pip3 install --upgrade pip setuptools && \
#     pip3 install torch torchvision torchaudio && \
#     pip3 install -r requirements.txt

# # https://developer.nvidia.com/cuda-gpus
# # for a rtx 2060: ARG TORCH_CUDA_ARCH_LIST="7.5"
# ARG TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5;8.0;8.6+PTX"
# RUN . /build/venv/bin/activate && \
#     python3 setup_cuda.py bdist_wheel -d .

FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

LABEL maintainer="Your Name <your.email@example.com>"
LABEL description="Docker image for GPTQ-for-LLaMa and Text Generation WebUI"

RUN apt-get update && \
    apt-get install --no-install-recommends -y git python3 python3-pip make g++ && \
    rm -rf /var/lib/apt/lists/*

# Set up a new user named "user" with user ID 1000
RUN useradd -m -u 1000 user

# Switch to the "user" user
USER user

# Set home to the user's home directory
ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH

ENV APP=$HOME/app

RUN --mount=type=cache,target=$HOME/.cache/pip pip3 install virtualenv

RUN mkdir $APP/
# Set the working directory to the user's home directory
WORKDIR $APP/

RUN virtualenv $APP/venv
RUN . $APP/venv/bin/activate && \
    pip3 install --upgrade pip setuptools && \
    pip3 install torch torchvision torchaudio

RUN git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa $APP/repositories/GPTQ-for-LLaMa

COPY --chown=user extensions/api/requirements.txt $APP/extensions/api/requirements.txt
COPY --chown=user extensions/elevenlabs_tts/requirements.txt $APP/extensions/elevenlabs_tts/requirements.txt
COPY --chown=user extensions/google_translate/requirements.txt $APP/extensions/google_translate/requirements.txt
COPY --chown=user extensions/silero_tts/requirements.txt $APP/extensions/silero_tts/requirements.txt
COPY --chown=user extensions/whisper_stt/requirements.txt $APP/extensions/whisper_stt/requirements.txt
RUN --mount=type=cache,target=$HOME/.cache/pip . $APP/venv/bin/activate && cd extensions/api && pip3 install -r requirements.txt
RUN --mount=type=cache,target=$HOME/.cache/pip . $APP/venv/bin/activate && cd extensions/elevenlabs_tts && pip3 install -r requirements.txt
RUN --mount=type=cache,target=$HOME/.cache/pip . $APP/venv/bin/activate && cd extensions/google_translate && pip3 install -r requirements.txt
RUN --mount=type=cache,target=$HOME/.cache/pip . $APP/venv/bin/activate && cd extensions/silero_tts && pip3 install -r requirements.txt
RUN --mount=type=cache,target=$HOME/.cache/pip . $APP/venv/bin/activate && cd extensions/whisper_stt && pip3 install -r requirements.txt

COPY --chown=user requirements.txt $APP/requirements.txt
RUN . $APP/venv/bin/activate && \
    pip3 install -r requirements.txt

RUN cp $APP/venv/lib/python3.10/site-packages/bitsandbytes/libbitsandbytes_cuda118.so $APP/venv/lib/python3.10/site-packages/bitsandbytes/libbitsandbytes_cpu.so

# Copy the current directory contents into the container at $APP/ setting the owner to the user
COPY --chown=user . $APP/

RUN . $APP/venv/bin/activate && python3 download-model.py TheBloke/galpaca-30B-GPTQ-4bit-128g --threads 16

RUN mv models/TheBloke_galpaca-30B-GPTQ-4bit-128g/galpaca-30B-4bit-128g.no-act-order.pt models/TheBloke_galpaca-30B-GPTQ-4bit-128g/TheBloke_galpaca-30B-GPTQ-4bit-128g-4bit.pt

ENV CLI_ARGS=""
CMD . $APP/venv/bin/activate && python3 server.py ${CLI_ARGS}
