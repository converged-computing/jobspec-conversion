#!/bin/bash
#FLUX: --job-name=phat-puppy-2173
#FLUX: -c=12
#FLUX: -t=1800
#FLUX: --priority=16

export OMP_PROC_BIND='true'

export OMP_PROC_BIND=true
srun bin/run-test triton build-omp $SLURM_ARRAY_TASK_ID
