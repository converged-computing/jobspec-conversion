#!/bin/bash
#SBATCH --job-name=PostProcess_example
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=4-04:00:00
#SBATCH --partition=parallel-12

lmp=~/software/lammps/lam*22/src/ # getting the correct run file location
mpirun $lmp/lmp_mpi < simulation.in # computing with n cpu cores.
wait
exit 0
