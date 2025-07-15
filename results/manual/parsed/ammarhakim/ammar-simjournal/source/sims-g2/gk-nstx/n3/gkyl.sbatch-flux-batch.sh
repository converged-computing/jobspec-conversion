#!/bin/bash
#FLUX: --job-name=blue-motorcycle-7859
#FLUX: --priority=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl n3-Lz4-no-collisions.lua
