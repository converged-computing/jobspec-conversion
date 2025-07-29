#!/bin/bash
#SBATCH --job-name=Train German Credit (ECCCo)
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=01:00:00

srun julia --project=experiments experiments/run_experiments.jl -- data=german_credit output_path=results only_models > experiments/train_german_credit.log
