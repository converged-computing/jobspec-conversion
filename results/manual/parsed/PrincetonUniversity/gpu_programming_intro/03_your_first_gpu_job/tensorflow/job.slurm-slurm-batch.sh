#!/bin/bash
#FLUX: --job-name=svd-tf
#FLUX: -t=120
#FLUX: --urgency=16

module purge
module load anaconda3/2023.9
conda activate /scratch/network/jdh4/.gpu_workshop/envs/tf2-gpu
python svd.py
