#!/bin/bash
#FLUX: --job-name=relgan-tf-no-gpu
#FLUX: -c=16
#FLUX: -t=1440
#FLUX: --urgency=16

source .venv/relgan/bin/activate
module load python/3.7
cd oracle/experiments
echo "Current working directory: `pwd`"
echo "Running main.py"
python oracle_relgan.py $SLURM_ARRAY_TASK_ID -1
