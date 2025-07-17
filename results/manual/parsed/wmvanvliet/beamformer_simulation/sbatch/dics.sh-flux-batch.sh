#!/bin/bash
#FLUX: --job-name=dics
#FLUX: -t=10800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

LOG_FILE=logs/dics.log
VERTEX_NUMBER=$(printf "%04d" $SLURM_ARRAY_TASK_ID)
module load anaconda
export OMP_NUM_THREADS=1
srun python ../dics.py -v $SLURM_ARRAY_TASK_ID -n 0.1 2>&1 | sed -e "s/^/$VERTEX_NUMBER:  /" >> $LOG_FILE
