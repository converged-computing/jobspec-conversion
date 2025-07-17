#!/bin/bash
#FLUX: --job-name=R2_calculations
#FLUX: -c=5
#FLUX: --queue=gpu
#FLUX: -t=129600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

unset SLURM_EXPORT_ENV
module load tensorflow/python-2.7/1.3.0 
/usr/bin/nvidia-smi
echo $SLURM_ARRAY_TASK_ID
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --cpu_bind=verbose python ./rebuttal_NN.py -f $SLURM_ARRAY_TASK_ID
