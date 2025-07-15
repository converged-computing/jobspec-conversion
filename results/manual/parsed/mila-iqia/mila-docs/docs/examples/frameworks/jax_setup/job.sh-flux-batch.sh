#!/bin/bash
#FLUX: --job-name=fat-pancake-3403
#FLUX: -t=900
#FLUX: --priority=16

set -e  # exit on error.
echo "Date:     $(date)"
echo "Hostname: $(hostname)"
module --quiet purge
module load anaconda/3
conda activate jax_ex
python main.py
