#!/bin/bash
#SBATCH --job-name=lammps_example
#SBATCH --output=lammps_job.%J.out
#SBATCH --error=lammps_job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2g
#SBATCH --time=00:15:00

module purge
module load compiler/gcc/11 openmpi/4.1 lammps/23June2022
mpirun lmp < in.atm
