#!/bin/bash
#FLUX: --job-name=slurm_run
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: -t=259200
#FLUX: --priority=16

ulimit -s 10240
ulimit -u 100000
srun -N 1 --ntasks-per-node=1 ./script.sh ${SLURM_ARRAY_TASK_ID} 
