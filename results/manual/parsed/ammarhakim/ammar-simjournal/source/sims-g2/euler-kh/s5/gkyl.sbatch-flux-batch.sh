#!/bin/bash
#FLUX: --job-name=crunchy-lemon-1629
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl s5-euler-kh.lua
