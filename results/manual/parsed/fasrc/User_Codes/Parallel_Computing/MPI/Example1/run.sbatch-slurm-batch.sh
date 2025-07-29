#!/bin/bash
#SBATCH --job-name=pi_monte_carlo
#SBATCH --output=pi_monte_carlo.out
#SBATCH --error=pi_monte_carlo.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:30:00
#SBATCH --partition=test

module load intel/24.0.1-fasrc01 openmpi/5.0.2-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./pi_monte_carlo.x
