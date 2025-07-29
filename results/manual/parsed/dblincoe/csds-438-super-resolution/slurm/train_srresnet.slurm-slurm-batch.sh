#!/bin/bash
#SBATCH --account=sxg125_csds438
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100gb
#SBATCH --time=05:00:00

module load cuda/11.2
source venv/bin/activate
python train.py \
    --model srresnet
