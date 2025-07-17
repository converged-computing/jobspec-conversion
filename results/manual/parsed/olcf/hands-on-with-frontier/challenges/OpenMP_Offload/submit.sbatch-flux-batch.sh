#!/bin/bash
#FLUX: --job-name=mat_mul
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

module load PrgEnv-amd
module load craype-accel-amd-gfx90a
module load openblas
srun -n1 -c1 --gpus-per-task=1 --gpu-bind=closest ./matrix_multiply
