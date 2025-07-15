#!/bin/bash
#FLUX: --job-name=strawberry-staircase-9732
#FLUX: --urgency=16

source activate tensorflow-stable
PYTHONPATH=$PWD python optimizers/smac/run_smac.py --seed $SLURM_ARRAY_TASK_ID --search_space $1
