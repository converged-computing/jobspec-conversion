#!/bin/bash
#SBATCH --job-name=ipi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load gcc
module load lammps
mpirun -n 1 lmp_mpi -i h2.in.lammps
exit 0
