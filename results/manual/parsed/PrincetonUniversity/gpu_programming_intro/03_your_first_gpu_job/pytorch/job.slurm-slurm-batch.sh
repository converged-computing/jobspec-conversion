#!/bin/bash
#FLUX: --job-name=torch-svd
#FLUX: -t=30
#FLUX: --urgency=16

module purge
module load anaconda3/2023.9
conda activate /scratch/network/jdh4/.gpu_workshop/envs/hf-env
python svd.py
