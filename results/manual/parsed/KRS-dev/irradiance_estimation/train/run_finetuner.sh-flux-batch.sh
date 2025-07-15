#!/bin/bash
#FLUX: --job-name=finetune ConvResNet
#FLUX: -c=24
#FLUX: --queue=normal
#FLUX: -t=12600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
module load daint-gpu 
source $SCRATCH/lightning-env/bin/activate
srun -ul python finetune.py
