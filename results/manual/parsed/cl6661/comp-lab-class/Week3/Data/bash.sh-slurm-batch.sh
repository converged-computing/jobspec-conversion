#!/bin/bash
#FLUX: --job-name=run-gromace-50ns
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun gmx_mpi mdrun -deffnm nvt
mpirun -np 1 gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
mpirun gmx_mpi mdrun -deffnm npt
mpirun -np 1 gmx_mpi grompp -f md50ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_50.tpr
mpirun gmx_mpi mdrun -deffnm md_0_50
