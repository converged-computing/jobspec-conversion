#!/bin/bash
#FLUX: --job-name=nerdy-muffin-9069
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module load cuda
module load Anaconda3
nvidia-smi
source activate wmlce_env
python model/main.py
