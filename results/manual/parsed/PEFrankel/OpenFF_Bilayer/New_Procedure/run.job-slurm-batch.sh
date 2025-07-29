#!/bin/bash
#SBATCH --job-name=POPE
#SBATCH --output=%x.out
#SBATCH --mail-user=pafr7911@colorado.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=amilan
#SBATCH --constraint=ntasks-per-node=64

ml gcc/11.2.0
ml openmpi/4.1.1
source /projects/dora1300/pkgs/gromacs-2022-cpu-mpi/bin/GMXRC
mpirun -np 64 gmx_mpi mdrun -deffnm nvt
mpirun -np 1 gmx_mpi grompp -p topol.top -f npt.mdp -c nvt.gro -o npt.tpr
mpirun -np 64 gmx_mpi mdrun -deffnm npt
mpirun -np 1 gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
mpirun -np 64 gmx_mpi mdrun -deffnm md
