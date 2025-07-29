#!/bin/bash
#SBATCH --job-name=mat_mul
#SBATCH --account=eel6763
#SBATCH --output=mat_mul.txt
#SBATCH --error=mat_mul.err
#SBATCH --mail-user=kshitijraj@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100mb
#SBATCH --time=00:05:00
#SBATCH --qos=eel6763
#SBATCH --constraint=ntasks-per-node=4

module load intel
mpicc -n 2  hybrid_mat_mult.c -o hyb -fopenmp 
srun --mpi=pmix_v2 ./hyb 4
