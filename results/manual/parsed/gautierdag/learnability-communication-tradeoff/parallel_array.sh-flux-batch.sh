#!/bin/bash
#FLUX: --job-name=proc-ce
#FLUX: -t=86400
#FLUX: --priority=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate gp
python -u process_results.py $SLURM_ARRAY_TASK_ID
