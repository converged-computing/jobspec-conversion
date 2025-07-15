#!/bin/bash
#FLUX: --job-name=mdrun
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2020.4
-np 1 gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_50.tpr
gmx_mpi mdrun -deffnm md_0_50
