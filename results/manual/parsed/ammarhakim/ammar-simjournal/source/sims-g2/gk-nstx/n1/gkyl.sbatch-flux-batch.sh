#!/bin/bash
#FLUX: --job-name=red-kitty-2102
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl n1-Lz4-no-collisions.lua
