#!/bin/bash
#FLUX: --job-name=stanky-hobbit-6689
#FLUX: --priority=16

ml gcc/11.2.0
ml openmpi/4.1.1
source /projects/dora1300/pkgs/gromacs-2022-cpu-mpi/bin/GMXRC
mpirun -np 64 gmx_mpi mdrun -deffnm nvt
mpirun -np 1 gmx_mpi grompp -p topol.top -f npt.mdp -c nvt.gro -o npt.tpr
mpirun -np 64 gmx_mpi mdrun -deffnm npt
mpirun -np 1 gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
mpirun -np 64 gmx_mpi mdrun -deffnm md
