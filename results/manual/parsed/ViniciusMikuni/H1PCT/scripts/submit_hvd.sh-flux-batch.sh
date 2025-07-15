#!/bin/bash
#FLUX: --job-name=carnivorous-kitty-4706
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --urgency=16

export HOROVOD_GPU_BROADCAST='MPI'
export HOROVOD_GPU_ALLGATHER='MPI'
export HOROVOD_GPU_ALLREDUCE='MPI'
export MPICH_ALLGATHERV_PIPELINE_MSG_SIZE='0'
export MPICH_MAX_THREAD_SAFETY='multiple'
export MPIR_CVAR_GPU_EAGER_DEVICE_MEM='0'

module load tensorflow
export HOROVOD_GPU_BROADCAST=MPI
export HOROVOD_GPU_ALLGATHER=MPI
export HOROVOD_GPU_ALLREDUCE=MPI
export MPICH_ALLGATHERV_PIPELINE_MSG_SIZE=0
export MPICH_MAX_THREAD_SAFETY=multiple
export MPIR_CVAR_GPU_EAGER_DEVICE_MEM=0
cd $HOME/H1/scripts
srun python Unfold_offline.py --closure --niter 30 --pct 
