#!/bin/bash
#SBATCH --job-name=MyMPIJob
#SBATCH --output=MyMPIJob-%j.out
#SBATCH --error=MyMPIJob-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

module load mpi/hpcx_2.7.0_intel_2020.2_slurm20
srun --mpi=pmix ./$1
