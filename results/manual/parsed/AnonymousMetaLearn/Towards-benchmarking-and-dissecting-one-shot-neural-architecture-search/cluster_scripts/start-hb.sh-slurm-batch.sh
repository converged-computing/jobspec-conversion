#!/bin/bash
#FLUX: --job-name=hyperband
#FLUX: --queue=bosch_gpu-rtx2080
#FLUX: --urgency=16

source activate tensorflow-stable
PYTHONPATH=$PWD python optimizers/hyperband/run_hyperband.py --seed $SLURM_ARRAY_TASK_ID --search_space $1
