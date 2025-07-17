#!/bin/bash
#FLUX: --job-name=hanky-leopard-7030
#FLUX: -t=1800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/tysweat0/.conda/envs/img2img/lib/python3.9/site-packages/nvidia/cublas/lib'

export LD_LIBRARY_PATH=/home/tysweat0/.conda/envs/img2img/lib/python3.9/site-packages/nvidia/cublas/lib
cd ~/StableComics/FullPipeline/
nvidia-smi --list-gpus
nvidia-smi --query-gpu=memory.total --format=csv
python run.py
