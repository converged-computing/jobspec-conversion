#!/bin/bash
#FLUX: --job-name=md_50ns
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 1 gmx_mpi grompp -f md_50ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_50ns.tpr
mpirun -np 48 gmx_mpi mdrun -s -deffnm md_50ns
