#!/bin/bash
#FLUX: --job-name=docker
#FLUX: --priority=16

source ~/anaconda3/etc/profile.d/conda.sh
conda activate optimol_cpu
python docker.py $SLURM_ARRAY_TASK_ID 200 --server $1 --exhaustiveness $2 --name $3 --oracle $4 --target $5
