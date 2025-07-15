#!/bin/bash
#FLUX: --job-name=quirky-sundae-3860
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl n3-Lz4-no-collisions.lua
