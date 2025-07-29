#!/bin/bash
#FLUX: --job-name=pusheena-noodle-1916
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
module list
srun -n 1 ./hello
