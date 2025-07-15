#!/bin/bash
#FLUX: --job-name=phat-bike-6704
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl c2-Lz4-lbo-collisions.lua
