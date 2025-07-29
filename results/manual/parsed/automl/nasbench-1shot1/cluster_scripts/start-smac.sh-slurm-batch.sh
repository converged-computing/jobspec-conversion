#!/bin/bash
#FLUX: --job-name=smac
#FLUX: --queue=ml_gpu-rtx2080
#FLUX: --urgency=16

source activate tensorflow-stable
PYTHONPATH=$PWD python optimizers/smac/run_smac.py --seed $SLURM_ARRAY_TASK_ID --search_space $1
