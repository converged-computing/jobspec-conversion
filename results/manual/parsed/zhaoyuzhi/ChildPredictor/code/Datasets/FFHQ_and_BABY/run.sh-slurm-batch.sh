#!/bin/bash
#SBATCH --job-name=datagenerate
#SBATCH --output=./data_generate.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --partition=Pixel

srun --mpi=pmi2 python -u dataset_tool.py create_from_images datasets/mixtureFace ./FFHQ-128x128
