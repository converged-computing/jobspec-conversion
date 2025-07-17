#!/bin/bash
#FLUX: --job-name=creamy-bicycle-0016
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

slmodules -s x86_E5v2_Mellanox_GPU
module load gcc cuda cudnn mvapich2 openblas
source venvs/venvs/emg_tn/bin/activate
srun python emg1.py
