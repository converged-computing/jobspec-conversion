#!/bin/bash
#FLUX: --job-name=faux-leopard-1723
#FLUX: --priority=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl n1-Lz4-no-collisions.lua
