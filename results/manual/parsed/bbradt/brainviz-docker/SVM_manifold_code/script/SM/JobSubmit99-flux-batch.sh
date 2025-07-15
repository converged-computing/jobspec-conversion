#!/bin/bash
#FLUX: --job-name=joyous-butter-1130
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/ '

sleep 10s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/ 
echo $HOSTNAME
module load Framework/Matlab2019b
matlab -batch s2SM99
sleep 10s
