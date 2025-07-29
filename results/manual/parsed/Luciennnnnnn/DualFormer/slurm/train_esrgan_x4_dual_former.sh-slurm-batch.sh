#!/bin/bash
#SBATCH --job-name=train_esrgan_x4_dual_former
#SBATCH --output=/home/sist/luoxin/projects/DualFormer/slurm_logs/job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=100G
#SBATCH --partition=dongliu

nvidia-smi
python /home/sist/luoxin/projects/DualFormer/basicsr/train.py --auto_resume -opt options/train/train_esrgan_x4_dual_former.yml
