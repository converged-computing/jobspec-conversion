#!/bin/bash
#SBATCH --job-name=fold2array
#SBATCH --output=adj_matrix_conversion_gpu.out
#SBATCH --error=adj_matrix_conversion_gpu.err
#SBATCH --mail-user=jake.kovalic@yale.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --mem=64G
#SBATCH --time=12:00:00
#SBATCH --partition=gpu

module load miniconda
conda activate env_3_8
python fold2array_batch.py
