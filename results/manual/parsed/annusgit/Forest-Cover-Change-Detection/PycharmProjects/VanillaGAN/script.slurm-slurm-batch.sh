#!/bin/bash
#SBATCH --job-name=gan
#SBATCH --output=gan.out
#SBATCH --error=gan.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:K20Xm:1
#SBATCH --time=05:00:00

module load gcc/latest
module load nvidia/7.5
module load cudnn/7.5-v5
python -m train.training_functions
