#!/bin/bash
#FLUX: --job-name=gkyl
#FLUX: -N=16
#FLUX: -n=256
#FLUX: -t=172800
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl s6-euler-kh.lua restart
