#!/bin/bash
#SBATCH --job-name=load_graphs_batch
#SBATCH --output=./logs/slurm/%x_%j.out
#SBATCH --error=./logs/slurm/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G
#SBATCH --time=02:00:00

module load miniconda
conda activate env_3_8
python load_batch.py
