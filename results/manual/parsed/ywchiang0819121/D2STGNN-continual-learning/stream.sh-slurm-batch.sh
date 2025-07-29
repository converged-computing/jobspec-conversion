#!/bin/bash
#SBATCH --job-name=D2STGNN2021
#SBATCH --output=/storage/internal/home/y-chiang/logs/output-%j.out
#SBATCH --error=/storage/internal/home/y-chiang/logs/slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=8
#SBATCH --exclude=cn[1-21,32-55]

/storage/internal/home/y-chiang/miniconda3/bin/python main_stream.py
