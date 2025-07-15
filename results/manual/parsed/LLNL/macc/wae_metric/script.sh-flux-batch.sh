#!/bin/bash
#FLUX: --job-name=faux-despacito-0681
#FLUX: --queue=pascal
#FLUX: --priority=16

source ~/.bashrc
source activate tfgpu
module load cuda/9.1.85
srun -N1 -n1 python -u run_WAE.py
