#!/bin/bash
#FLUX: --job-name=doopy-pedo-0222
#FLUX: -c=12
#FLUX: --queue=short
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_PROC_BIND='true'

export OMP_PROC_BIND=true
srun bin/run-test triton build-omp $SLURM_ARRAY_TASK_ID
