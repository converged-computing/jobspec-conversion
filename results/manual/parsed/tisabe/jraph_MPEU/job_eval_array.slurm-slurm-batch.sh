#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=short
#FLUX: -t=86399
#FLUX: --urgency=16

module load cuda
python3 scripts/plotting/error_analysis.py \
--file=results/aflow/kfold_Ef/id${SLURM_ARRAY_TASK_ID} \
