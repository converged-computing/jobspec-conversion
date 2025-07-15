#!/bin/bash
#FLUX: --job-name="train ConvResNet"
#FLUX: -N=2
#FLUX: -c=24
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
module load daint-gpu 
source $SCRATCH/lightning-env/bin/activate
srun -ul python validate.py
