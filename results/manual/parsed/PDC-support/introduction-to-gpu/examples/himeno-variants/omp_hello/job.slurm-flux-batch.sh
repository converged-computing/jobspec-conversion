#!/bin/bash
#FLUX: --job-name=phat-noodle-7275
#FLUX: --urgency=16

module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
module list
srun -n 1 ./hello
