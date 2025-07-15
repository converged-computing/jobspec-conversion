#!/bin/bash
#FLUX: --job-name=nerdy-punk-2708
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'

module purge
module load PrgEnv-amd
module load amd/5.4.3
module load cray-mpich/8.1.26
module load craype-accel-amd-gfx90a
module load cmake/3.23.2
module list
export MPICH_GPU_SUPPORT_ENABLED=1
OMP_NUM_THREADS=7 srun -N1 -n1 -c7 --ntasks-per-node=1 ../build/mini-apps/lbm2d-letkf/thrust/lbm2d-letkf-thrust --filename nudging_512.json
