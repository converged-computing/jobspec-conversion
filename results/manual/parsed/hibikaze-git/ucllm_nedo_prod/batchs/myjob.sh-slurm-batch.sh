#!/bin/bash
#SBATCH --job-name=example
#SBATCH --output=example.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --partition=g2

cd ~/ucllm_nedo_prod
nvidia-smi
