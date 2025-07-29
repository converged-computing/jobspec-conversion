#!/bin/bash
#SBATCH --job-name=Train Tabular (ECCCo)
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=05:00:00
#SBATCH --partition=general

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
srun julia --project=experiments experiments/run_experiments.jl -- data=gmsc,german_credit,california_housing output_path=results only_models > experiments/train_tabular.log
