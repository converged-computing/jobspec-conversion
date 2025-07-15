#!/bin/bash
#FLUX: --job-name=persnickety-diablo-1977
#FLUX: --priority=16

module load PrgEnv-amd
module load openblas
srun -n1 -c1 --gpus-per-task=1 --gpu-bind=closest ./cpu_gpu_dgemm
