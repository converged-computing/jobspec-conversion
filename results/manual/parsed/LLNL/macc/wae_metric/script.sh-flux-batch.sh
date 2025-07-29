#!/bin/bash
#FLUX --job-name=delicious-buttface-2284
#FLUX --queue=pbatch
#FLUX -t=28800
#FLUX --urgency=16

source ~/.bashrc
source activate tfgpu
module load cuda/9.1.85
srun -N1 -n1 python -u run_WAE.py
