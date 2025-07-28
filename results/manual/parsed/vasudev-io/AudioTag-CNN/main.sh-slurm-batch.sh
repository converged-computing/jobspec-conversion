#!/bin/bash
#FLUX: --job-name=cw
#FLUX: --queue=teach_gpu
#FLUX: -t=10800
#FLUX: --urgency=16

mkdir -p ./bc4_out
module purge
module load "languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch"
python3 main.py --epochs 10 --learning-rate 0.2 --sgd-momentum 0.93 --op sgd --model ChunkResCNN1 --conv-length 256 --conv-stride 256
