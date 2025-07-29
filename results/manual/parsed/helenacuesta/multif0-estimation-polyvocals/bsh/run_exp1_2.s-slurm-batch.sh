#!/bin/bash
#SBATCH --job-name=exp2
#SBATCH --output=exp2.out
#SBATCH --error=exp2.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=6-00:00:00

module purge
module load cudnn/7.0v4.0
module load cuda/10.1.105
python 2_training.py --model model2 --save_key exp2multif0 --data_splits_file data_splits.json
