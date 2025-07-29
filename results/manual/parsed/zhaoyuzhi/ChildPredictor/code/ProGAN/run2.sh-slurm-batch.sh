#!/bin/bash
#SBATCH --job-name=datagenerate
#SBATCH --output=./data_generate_FFHQ.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0

srun --mpi=pmi2 python -u dataset_tool2.py create_from_images datasets/FFHQFace ../Datasets/FFHQ/FFHQ-128x128/
