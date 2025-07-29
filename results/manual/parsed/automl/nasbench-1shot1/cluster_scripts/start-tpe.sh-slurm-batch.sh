#!/bin/bash
#FLUX: --job-name=tpe-nasbench
#FLUX: --queue=bosch_gpu-rtx2080
#FLUX: --urgency=16

source activate tensorflow-stable
PYTHONPATH=$PWD python optimizers/tpe/run_tpe.py --seed $SLURM_ARRAY_TASK_ID --search_space $1
