#!/bin/bash
#SBATCH --job-name=datasets
#SBATCH --output=outputs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --time=23:59:00
#SBATCH --partition=red

module load singularity
singularity run --nv --bind /home/data_shares/geocv:/home/data_shares/geocv /opt/itu/containers/pytorch/latest python3 src/create_datasets.py
