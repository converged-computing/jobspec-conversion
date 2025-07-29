#!/bin/bash
#SBATCH --job-name=mpitest
#SBATCH --output=mpitest.out
#SBATCH --error=mpitest.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00
#SBATCH --partition=test

module load intel/24.0.1-fasrc01  intelmpi/2021.11-fasrc01
srun -n $SLURM_NTASKS --mpi=pmi2 ./mpitest.x
