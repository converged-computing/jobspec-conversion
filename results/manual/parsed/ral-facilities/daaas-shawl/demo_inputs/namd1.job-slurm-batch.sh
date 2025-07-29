#!/bin/bash
#SBATCH --job-name=dppc-p1
#SBATCH --output=dppc.log
#SBATCH --error=dppc.err
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=24

module use /apps/eb/modulefiles/all
module load NAMD/2.14-foss-2019b-mpi
mpirun -np 144 namd2 dppc-p1.conf > dppc-p1.out
