#!/bin/bash
#FLUX: --job-name=moolicious-muffin-3682
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

cd /ceph/project/tendonhca/albrecht/003-snakemake/
eval "$(/project/sims-lab/albrecht/miniforge3/bin/conda shell.bash hook)" && conda activate base
conda activate envs/cell2location-nb
module load cuda/12.2
PYTORCH_ENABLE_MPS_FALLBACK=1 jupyter nbconvert --to notebook --allow-errors --execute notebooks/hamstring-gpu.ipynb
