#!/bin/bash
#SBATCH --account=def-lulam50
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:lgpu:4
#SBATCH --mem=0
#SBATCH --time=00:03:00

hostname
nvidia-smi
