#!/bin/bash
#FLUX: --job-name=md_50ns
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2020.4
gmx_mpi grompp -f nvt.mdp -c en_min.gro -r en_min.gro -p topol.top -o nvt.tpr
mpirun -np 48 gmx_mpi mdrun -deffnm nvt
gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
mpirun -np 48 gmx_mpi mdrun -deffnm npt
mpirun -np 1 gmx_mpi grompp -f md_50ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_50ns.tpr
mpirun -np 48 gmx_mpi mdrun  -deffnm md_50ns 
