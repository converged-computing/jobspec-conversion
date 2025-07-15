#!/bin/bash
#FLUX: --job-name=bench2
#FLUX: -N=2
#FLUX: --queue=main
#FLUX: -t=600
#FLUX: --priority=16

ml PDC/21.09 
ml all-spack-modules/0.16.3
ml CMake/3.21.2
source ${PWD}/bin/GMXRC
srun gmx_mpi mdrun -deffnm MD -npme 0 -g GLIC_2n_64_4_DLBNO.log -resetstep 20000 -ntomp 4 -dlb yes -pin on -pinstride 2
