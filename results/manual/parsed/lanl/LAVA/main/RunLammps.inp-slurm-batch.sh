#!/bin/bash
#SBATCH --job-name=Lava_Wrapper
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=C5

module purge
module load gnu8
module load openmpi3
mpirun lammps_executable -in lammps.in -sf opt
