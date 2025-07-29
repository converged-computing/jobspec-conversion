#!/bin/bash
#SBATCH --job-name=MD
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=5-01:00:00
#SBATCH --partition=smaug-c

mpirun ~/scratch/lammps/src/lmp_mpi -in system.run2
