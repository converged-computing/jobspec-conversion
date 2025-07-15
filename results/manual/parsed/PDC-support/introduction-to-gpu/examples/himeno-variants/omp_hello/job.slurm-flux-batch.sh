#!/bin/bash
#FLUX: --job-name=joyous-despacito-5719
#FLUX: --priority=16

module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
module list
srun -n 1 ./hello
