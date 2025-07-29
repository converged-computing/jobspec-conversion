#!/bin/bash
#SBATCH --job-name=FBtest
#SBATCH --output=FBtest.o%A
#SBATCH --nodes=256
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --partition=early_science
#SBATCH --constraint=gpu,ntasks-per-node=4

export CRAY_ACCEL_TARGET='nvidia80'
export MPICH_GPU_SUPPORT_ENABLED='1'
export NCCL_NET_GDR_LEVEL='PHB'

export CRAY_ACCEL_TARGET=nvidia80
export MPICH_GPU_SUPPORT_ENABLED=1
export NCCL_NET_GDR_LEVEL=PHB
EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
