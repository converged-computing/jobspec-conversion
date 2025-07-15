#!/bin/bash
#FLUX: --job-name=arid-malarkey-8575
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

cd /ceph/project/tendonhca/albrecht/003-snakemake/
eval "$(/project/sims-lab/albrecht/miniforge3/bin/conda shell.bash hook)" && conda activate base
conda activate envs/cell2location-nb
jupyter nbconvert --to notebook --execute ./hamstring-gpu.ipynb
