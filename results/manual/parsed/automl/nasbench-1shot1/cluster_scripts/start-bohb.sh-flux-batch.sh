#!/bin/bash
#FLUX: --job-name=anxious-latke-1795
#FLUX: --priority=16

source activate tensorflow-stable
PYTHONPATH=$PWD python optimizers/bohb/run_bohb.py --seed $SLURM_ARRAY_TASK_ID --search_space $1
