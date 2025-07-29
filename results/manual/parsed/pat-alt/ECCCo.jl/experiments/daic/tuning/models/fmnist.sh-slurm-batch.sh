#!/bin/bash
#SBATCH --job-name=Tune Fashion MNIST Model (ECCCo)
#SBATCH --account=innovation
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=05:00:00
#SBATCH --partition=general

srun julia --project=experiments experiments/run_experiments.jl -- data=fmnist output_path=results tune_model
