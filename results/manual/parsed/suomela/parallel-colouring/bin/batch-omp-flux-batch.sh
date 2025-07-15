#!/bin/bash
#FLUX: --job-name=delicious-lettuce-4213
#FLUX: -c=12
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_PROC_BIND='true'

export OMP_PROC_BIND=true
srun bin/run-test triton build-omp $SLURM_ARRAY_TASK_ID
