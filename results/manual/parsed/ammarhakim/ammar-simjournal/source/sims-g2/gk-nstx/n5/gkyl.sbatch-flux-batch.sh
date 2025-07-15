#!/bin/bash
#FLUX: --job-name=hairy-lettuce-5842
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl n5-Lz4-no-collisions.lua
