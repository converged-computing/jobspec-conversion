#!/bin/bash
#FLUX: --job-name=misunderstood-leg-9780
#FLUX: --urgency=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl s6-euler-kh.lua restart
