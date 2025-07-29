#!/bin/bash
#SBATCH --job-name=Simglucose DDPG
#SBATCH --mail-user=yanis.schaerer@students.unibe.ch
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:rtx2080ti:2
#SBATCH --mem=2G
#SBATCH --time=01:30:00
#SBATCH --partition=gpu

singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install -U -e simglucose_local # Gym will also be installed
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime python train_ubelix.py
