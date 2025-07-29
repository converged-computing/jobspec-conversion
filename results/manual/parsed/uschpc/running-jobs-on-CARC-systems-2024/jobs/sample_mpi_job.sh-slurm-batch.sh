#!/bin/bash
#SBATCH --account=<account_id>
#SBATCH --nodes=3
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=512MB
#SBATCH --time=00:05:00
#SBATCH --chdir=/home1/ttrojan/running-jobs-on-CARC-2024

module purge
module load usc
srun --mpi=pmix_v2 --ntasks $SLURM_NTASKS data/mpi_sample/mpi_hello_world
