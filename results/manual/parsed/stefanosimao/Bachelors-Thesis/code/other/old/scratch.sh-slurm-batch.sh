#!/bin/bash
#FLUX: --job-name=cnn
#FLUX: -N=10
#FLUX: -c=12
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NCCL_DEBUG='INFO'
export NCCL_IB_HCA='ipogif0'
export NCCL_IB_CUDA_SUPPORT='1'

module load daint-gpu
module load PyTorch
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NCCL_DEBUG=INFO
export NCCL_IB_HCA=ipogif0
export NCCL_IB_CUDA_SUPPORT=1
srun python main.py
