#!/bin/bash
#FLUX: --job-name=psycho-malarkey-5264
#FLUX: --priority=16

module load intel
module load intel-mpi
srun --mpi=pmix /home/ammar/gkylsoft/gkyl/bin/gkyl s6-euler-kh.lua restart
