#!/bin/bash
#SBATCH --job-name=tensorflow-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:gtx745
#SBATCH --partition=gpu

module load cuda
python versuch2.1.py
