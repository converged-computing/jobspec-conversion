#!/bin/bash
#FLUX: --job-name=conspicuous-arm-4741
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
module list
echo '--- Run solution_hip ---'
time srun -n 1 solution_hip
