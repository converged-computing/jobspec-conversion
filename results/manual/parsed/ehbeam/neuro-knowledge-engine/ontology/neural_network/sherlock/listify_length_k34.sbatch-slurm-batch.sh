#!/bin/bash
#FLUX: --job-name=k34_listlen
#FLUX: --queue=aetkin
#FLUX: -t=172800
#FLUX: --urgency=16

module load python/3.6 py-pytorch/1.0.0_py36
srun python3 listify_length_k34.py
