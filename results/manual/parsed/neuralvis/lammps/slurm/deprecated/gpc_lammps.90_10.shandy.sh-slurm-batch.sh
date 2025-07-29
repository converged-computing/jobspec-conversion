#!/bin/bash
#SBATCH --job-name=gpc_lammps.001
#SBATCH --output=stdout/gpc_lammps.001.%J.out
#SBATCH --error=stdout/gpc_lammps.001.%J.err
#SBATCH --nodes=927
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=512
#SBATCH --time=06:00:00

module restore PrgEnv-cray
module load cray-mpich/8.0.15
srun --exclusive -N 93 -n 372 \
     /home/users/msrinivasa/develop/lammps/build/lmp+tracing \
     -i /home/users/msrinivasa/develop/lammps/examples/DIFFUSE/in.msd.2d > lammps.out
