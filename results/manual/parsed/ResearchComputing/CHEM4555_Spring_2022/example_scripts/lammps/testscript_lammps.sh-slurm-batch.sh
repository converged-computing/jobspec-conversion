#!/bin/bash
#SBATCH --job-name=lammps-test
#SBATCH --output=lammps-test.%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --partition=shas
#SBATCH --constraint=ntasks-per-node=1

module purge
module load intel/17.4
module load impi/17.3
module load lammps/29Oct20
mpirun -np 2 lmp_mpi -in in.atm
