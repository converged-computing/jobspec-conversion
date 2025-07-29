#!/bin/bash
#SBATCH --job-name=msm
#SBATCH --account=swanson-gpu-np
#SBATCH --output=msm.out
#SBATCH --error=err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:2080ti:1
#SBATCH --mem=300G
#SBATCH --time=2-00:00:00
#SBATCH --partition=swanson-gpu-np

python3 calling_func_v3.py
echo "... Job Finished at `date`"
