#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=00:20:00

MV2_USE_ALIGNED_ALLOC=1
module load mvapich2-2.3.7-gcc-11.2.0
time mpirun -n 4 julia rk45_main_multiple.jl
module unload mvapich2-2.3.7-gcc-11.2.0
