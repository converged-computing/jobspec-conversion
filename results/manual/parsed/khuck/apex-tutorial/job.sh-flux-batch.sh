#!/bin/bash
#FLUX: --job-name=pusheena-lentil-0342
#FLUX: -c=8
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='close'
export OMP_PLACES='threads'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=close
export OMP_PLACES=threads
module load cuda/11.5.0 cmake papi APEX
srun ./build/bin/pthread_c
