#!/bin/bash
#FLUX: --job-name=baseline
#FLUX: -t=259200
#FLUX: --urgency=16

module load nvidia/cuda11.2-cudnn8.1.0
module load anaconda3
source activate sockeye
pip install sockeye
pip install --pre -f https://dist.mxnet.io/python 'mxnet-cu112>=2.0.0b2021'
pip install mxboard
stdbuf -o0 -e0 srun --unbuffered $1 $2
