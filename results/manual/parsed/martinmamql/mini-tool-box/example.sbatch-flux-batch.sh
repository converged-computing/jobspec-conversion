#!/bin/bash
#FLUX: --job-name=cowy-parsnip-5457
#FLUX: -c=24
#FLUX: --queue=gpu_high
#FLUX: -t=259200
#FLUX: --urgency=16

module load singularity # this is for singularity
ulimit -n 40000 # this is for singularity and large memory jobs, you could change 40000 to suitable numbers
kill -9 $(nvidia-smi | sed -n 's/|\s*[0-9]*\s*\([0-9]*\)\s*.*/\1/p' | sort | uniq | sed '/^$/d')
CUDA_VISIBLE_DEVICES=0 python xxx.py
