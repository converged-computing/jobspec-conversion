#!/bin/bash
#SBATCH --job-name=array
#SBATCH --account=kicp
#SBATCH --output=logs/log_uniformRate.out
#SBATCH --error=logs/log_uniformRate.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=12:00:00
#SBATCH --partition=kicp

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
cd /home/tcallister/repositories/stochastic-birefringence/code/
conda activate stochastic-birefringence
python run_birefringence_uniformRate.py
