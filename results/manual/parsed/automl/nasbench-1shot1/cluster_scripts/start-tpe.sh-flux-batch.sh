#!/bin/bash
#FLUX: --job-name=joyous-lizard-2489
#FLUX: --urgency=16

source activate tensorflow-stable
PYTHONPATH=$PWD python optimizers/tpe/run_tpe.py --seed $SLURM_ARRAY_TASK_ID --search_space $1
