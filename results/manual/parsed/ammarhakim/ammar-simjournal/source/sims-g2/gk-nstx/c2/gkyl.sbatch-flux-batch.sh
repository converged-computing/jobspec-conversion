#!/bin/bash
#FLUX: --job-name=gkyl
#FLUX: -N=4
#FLUX: -n=64
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl c2-Lz4-lbo-collisions.lua
