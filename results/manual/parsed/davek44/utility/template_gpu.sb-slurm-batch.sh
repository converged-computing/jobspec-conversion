#!/bin/bash
#SBATCH --job-name=3/5_name
#SBATCH --output=train_name.out
#SBATCH --error=train_name.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:nvidia_geforce_gtx_1080_ti:1
#SBATCH --mem=23000
#SBATCH --time=2-00:00:00

. /home/drk/anaconda3/etc/profile.d/conda.sh
conda activate tf210
basenji_train.py
