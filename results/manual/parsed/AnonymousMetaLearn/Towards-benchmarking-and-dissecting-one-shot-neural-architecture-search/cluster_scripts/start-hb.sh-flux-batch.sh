#!/bin/bash
#FLUX: --job-name=wobbly-lemur-0663
#FLUX: --priority=16

source activate tensorflow-stable
PYTHONPATH=$PWD python optimizers/hyperband/run_hyperband.py --seed $SLURM_ARRAY_TASK_ID --search_space $1
