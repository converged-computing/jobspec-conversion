#!/bin/bash
#FLUX: --job-name=HIP
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'

module load PrgEnv-amd
module load rocm
module load craype-accel-amd-gfx90a
module load craype-x86-milan
module load cray-libsci_acc
export MPICH_GPU_SUPPORT_ENABLED=1
srun --ntasks=2 --cpus-per-task=8 ./a.out
