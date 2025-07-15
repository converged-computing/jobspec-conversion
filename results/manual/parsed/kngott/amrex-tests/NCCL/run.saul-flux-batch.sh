#!/bin/bash
#FLUX: --job-name=placid-cherry-3175
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export CRAY_ACCEL_TARGET='nvidia80'
export MPICH_GPU_SUPPORT_ENABLED='1'
export NCCL_NET_GDR_LEVEL='PHB'

export CRAY_ACCEL_TARGET=nvidia80
export MPICH_GPU_SUPPORT_ENABLED=1
export NCCL_NET_GDR_LEVEL=PHB
EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
