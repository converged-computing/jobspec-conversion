#!/bin/bash
#FLUX: --job-name=purple-leader-5410
#FLUX: --queue=pascal
#FLUX: --urgency=16

source ~/.bashrc
source activate tfgpu
module load cuda/9.1.85
srun -N1 -n1 python -u run_WAE.py
