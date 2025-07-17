#!/bin/bash
#FLUX: --job-name=job1
#FLUX: -N=64
#FLUX: --queue=standard-g
#FLUX: -t=15000
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'

module load CrayEnv PrgEnv-cray craype-accel-amd-gfx90a cray-mpich rocm fftw
CPU_BIND="map_cpu:48,56,16,24,1,8,32,40"
export MPICH_GPU_SUPPORT_ENABLED=1
srun --cpu-bind=${CPU_BIND} ./program
