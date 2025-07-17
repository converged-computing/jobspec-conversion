#!/bin/bash
#FLUX: --job-name=gkyl
#FLUX: -N=9
#FLUX: -n=144
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl n1-Lz4-no-collisions.lua
