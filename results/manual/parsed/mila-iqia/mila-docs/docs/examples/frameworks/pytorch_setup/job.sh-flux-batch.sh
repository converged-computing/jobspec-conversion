#!/bin/bash
#FLUX: --job-name=psycho-kerfuffle-1195
#FLUX: -t=900
#FLUX: --priority=16

set -e  # exit on error.
echo "Date:     $(date)"
echo "Hostname: $(hostname)"
module --quiet purge
module load anaconda/3
conda activate pytorch
unset CUDA_VISIBLE_DEVICES
python main.py
