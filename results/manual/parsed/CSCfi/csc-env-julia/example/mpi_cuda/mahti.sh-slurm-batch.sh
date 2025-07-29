#!/bin/bash
#SBATCH --job-name=cuda
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=00:15:00
#SBATCH --partition=gputest
#SBATCH --constraint=ntasks-per-node=2

module load julia/1.8.5
srun julia --project=. test.jl
