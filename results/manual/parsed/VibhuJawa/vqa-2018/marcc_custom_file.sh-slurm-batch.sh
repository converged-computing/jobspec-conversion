#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=16:00:00

module load cuda/9.0
python test.py
python main1.py --num-workers 8 --batch-size 128 --epochs 30 --lr 1e-6
