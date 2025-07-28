#!/bin/bash
#FLUX: --job-name=doopy-buttface-9030
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load cuda
module load Anaconda3
nvidia-smi
source activate wmlce_env
python model/main.py
