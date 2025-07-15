#!/bin/bash
#FLUX: --job-name=boopy-avocado-9677
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/ '

sleep 10s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/ 
echo $HOSTNAME
module load Framework/Matlab2019b
matlab -batch s2CC12
sleep 10s
