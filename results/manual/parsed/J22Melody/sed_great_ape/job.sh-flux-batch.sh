#!/bin/bash
#FLUX: --job-name=baseline
#FLUX: -t=172800
#FLUX: --urgency=16

module load cudnn/7.6.5.32-10.2
module load anaconda3
source activate audio_clf
CUBLAS_WORKSPACE_CONFIG=:4096:8 stdbuf -o0 -e0 srun --unbuffered python model.py -c $1
