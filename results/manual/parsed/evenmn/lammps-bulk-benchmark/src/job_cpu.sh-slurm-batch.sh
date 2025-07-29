#!/bin/bash
#SBATCH --job-name=cpu
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --array=1-10

mpirun lmp_test -in in.lammps
