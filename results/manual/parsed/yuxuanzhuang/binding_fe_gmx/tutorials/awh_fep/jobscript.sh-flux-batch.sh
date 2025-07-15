#!/bin/bash
#FLUX: --job-name=stinky-kitty-8570
#FLUX: --priority=16

module unload gromacs
module switch gromacs/2023 gromacs=gmx_mpi
module switch cuda/11.8
module unload openmpi
module load openmpi
srun -n 8 gmx_mpi mdrun -deffnm awh -cpi awh -multidir rep{1..8} -awh awhinit.xvg -px awh_pullx -pf awh_pullf -maxh 23 -dhdl dhdl
