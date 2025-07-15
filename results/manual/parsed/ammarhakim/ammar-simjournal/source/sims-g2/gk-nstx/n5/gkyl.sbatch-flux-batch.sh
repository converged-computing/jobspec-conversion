#!/bin/bash
#FLUX: --job-name=gassy-spoon-0816
#FLUX: --priority=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl n5-Lz4-no-collisions.lua
