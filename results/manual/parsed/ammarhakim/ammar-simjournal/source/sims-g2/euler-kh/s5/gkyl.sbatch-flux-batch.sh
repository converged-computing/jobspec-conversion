#!/bin/bash
#FLUX: --job-name=joyous-knife-1983
#FLUX: --priority=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl s5-euler-kh.lua
