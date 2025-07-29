#!/bin/bash
#SBATCH --output=python_array_job_slurm_%j.out
#SBATCH --error=python_array_job_slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=50G
#SBATCH --time=5-10:00:00
#SBATCH --partition=gpu

python < /gpfsnyu/home/yz6492/on-lstm/code/main.py
