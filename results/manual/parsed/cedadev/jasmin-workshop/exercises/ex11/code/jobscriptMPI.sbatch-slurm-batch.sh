#!/bin/bash
#SBATCH --job-name=axpyMPI
#SBATCH --account=workshop
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100
#SBATCH --time=00:05:00

module load intel/20.0.0
module load eb/OpenMPI/intel/3.1.1
mpirun ./axpyMPI.exe
