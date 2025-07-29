#!/bin/bash
#SBATCH --account=m1759_g
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --partition=early_science
#SBATCH: --exclusive
#SBATCH --constraint=gpu,ntasks-per-node=4

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
