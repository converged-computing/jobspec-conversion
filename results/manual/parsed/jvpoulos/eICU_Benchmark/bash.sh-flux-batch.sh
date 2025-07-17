#!/bin/bash
#FLUX: --job-name=bash
#FLUX: -c=6
#FLUX: --queue=scavenger-gpu
#FLUX: --urgency=16

module load CUDA/10.1
nvcc -V
nvidia-smi
source /hpc/home/jvp5/storage/venv/bin/activate
python bash.py
