#!/bin/bash
#FLUX: --job-name=gloopy-leopard-9409
#FLUX: --urgency=16

module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
module list
echo '--- Run solution_hip ---'
time srun -n 1 solution_hip
