#!/bin/bash
#SBATCH --account=accre_gpu
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --partition=maxwell
#SBATCH --constraint=ntasks-per-node=1

source job-env.sh
srun --mpi=pmi2 ./mpi_jobs.py
