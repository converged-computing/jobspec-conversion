#!/bin/bash
#FLUX: --job-name=Milano
#FLUX: -c=40
#FLUX: -t=86400
#FLUX: --urgency=16

docker run --runtime=nvidia --rm --name AAA -v \
/home/okuchaiev:/home/okuchaiev -v /mnt:/mnt --shm-size=1G \
--ulimit memlock=-1 --ulimit stack=67108864 \
gitlab-dl.nvidia.com:5005/dgx/pytorch:18.07-py3-stage \ # CHANGE THIS to Pytorch container of your choice. Visit ngc.nvidia.com for NVIDIA's Pytorch containers
/bin/bash -c 'nvidia-smi &&\
 mkdir tmp && cd tmp &&\
 git clone https://github.com/pytorch/examples.git &&\
 cd examples/word_language_model && python main.py --cuda --epochs 6 --save $RANDOM  "$@"'
