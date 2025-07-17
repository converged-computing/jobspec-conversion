#!/bin/bash
#FLUX: --job-name=wobbly-taco-4192
#FLUX: --urgency=16

srun /d/hpc/home/go7745/4/procesi/grpc/grpc -s localhost -p 8100 -id $SLURM_ARRAY_TASK_ID -n $SLURM_ARRAY_TASK_COUNT
