#!/bin/bash
#SBATCH --job-name=Train Fashion MNIST (ECCCo)
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=03:00:00

srun julia --project=experiments experiments/run_experiments.jl -- data=fmnist output_path=results only_models > experiments/train_fmnist.log
