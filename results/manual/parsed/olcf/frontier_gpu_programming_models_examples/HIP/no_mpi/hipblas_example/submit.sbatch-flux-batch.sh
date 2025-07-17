#!/bin/bash
#FLUX: --job-name=hanky-poo-0856
#FLUX: --queue=batch
#FLUX: -t=300
#FLUX: --urgency=16

module load PrgEnv-amd
module load craype-accel-amd-gfx90a
module load openblas
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/cpu_gpu_dgemm
