#!/bin/bash
#SBATCH --job-name=exp7
#SBATCH --output=exp7.out
#SBATCH --error=exp7.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=7-00:00:00

module purge
module load cudnn/7.0v4.0
module load cuda/10.1.105
python 3_training_nophase.py --save_key exp7multif0 --data_splits_file data_splits.json
