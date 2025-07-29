#!/bin/bash
#SBATCH --job-name=amd-e322
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:mi50:1
#SBATCH --mem=20GB
#SBATCH --time=1-12:00:00

module purge
