#!/bin/bash
#FLUX: --job-name=k46_listlen
#FLUX: -t=172800
#FLUX: --priority=16

module load python/3.6 py-pytorch/1.0.0_py36
srun python3 listify_length_k46.py
