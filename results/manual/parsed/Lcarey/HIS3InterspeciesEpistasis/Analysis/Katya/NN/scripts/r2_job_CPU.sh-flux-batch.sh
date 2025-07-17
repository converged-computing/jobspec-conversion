#!/bin/bash
#FLUX: --job-name=R2_calculations
#FLUX: -c=10
#FLUX: --queue=defaultp
#FLUX: -t=129600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

unset SLURM_EXPORT_ENV
module load tensorflow/python-2.7/1.4.0-avx
echo $SLURM_ARRAY_TASK_ID
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --cpu_bind=verbose python ./network.py -c S$SLURM_ARRAY_TASK_ID -n 75
