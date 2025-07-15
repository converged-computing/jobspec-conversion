#!/bin/bash
#FLUX: --job-name=chunky-leg-5084
#FLUX: --priority=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl c2-Lz4-lbo-collisions.lua
