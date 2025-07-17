#!/bin/bash
#FLUX: --job-name=cuffthrust
#FLUX: --urgency=16

. /etc/profile
module load cuda/5.0
module load mpi/mpich/3.0.4-intel
module load libs/fftw/3.3.3 
srun cat /proc/cpuinfo > cpuinfo.dat
srun deviceQuery > gpuinfo.dat
echo
echo "=== CUFFT ==="
time srun --gres=gpu:1 -n1 simple_cufft
echo 
wait
