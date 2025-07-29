#!/bin/bash
#SBATCH --job-name=md_50ns
#SBATCH --output=md_50ns.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=48

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 1 gmx_mpi grompp -f md_50ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_50ns.tpr
mpirun -np 48 gmx_mpi mdrun -s -deffnm md_50ns
