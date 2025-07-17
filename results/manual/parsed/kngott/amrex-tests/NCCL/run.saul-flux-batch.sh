#!/bin/bash
#FLUX: --job-name=FBtest
#FLUX: -N=256
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --queue=early_science
#FLUX: -t=900
#FLUX: --urgency=16

export CRAY_ACCEL_TARGET='nvidia80'
export MPICH_GPU_SUPPORT_ENABLED='1'
export NCCL_NET_GDR_LEVEL='PHB'

export CRAY_ACCEL_TARGET=nvidia80
export MPICH_GPU_SUPPORT_ENABLED=1
export NCCL_NET_GDR_LEVEL=PHB
EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
