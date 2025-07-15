#!/bin/bash
#FLUX: --job-name="bash"
#FLUX: --priority=16

module load CUDA/10.1
nvcc -V
nvidia-smi
source /hpc/home/jvp5/storage/venv/bin/activate
python bash.py
