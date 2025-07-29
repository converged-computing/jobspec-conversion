#!/bin/bash
#SBATCH --job-name=plot_spectral_profile
#SBATCH --output=/home/sist/luoxin/projects/DualFormer/slurm_logs/job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=100G

nvidia-smi
python /home/sist/luoxin/projects/DualFormer/scripts/plot_spectral_profile.py
