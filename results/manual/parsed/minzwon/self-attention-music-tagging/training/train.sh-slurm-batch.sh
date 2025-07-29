#!/bin/bash
#SBATCH --job-name=msd
#SBATCH --output=/homedtic/mwon/codes/music-tagging-attention/training/log/msd.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128GB
#SBATCH --partition=high
#SBATCH --constraint=amd
#SBATCH --chdir=/homedtic/mwon/codes/music-tagging-attention/training

module load Python/3.6.4-foss-2017a
module load CUDA/9.0.176
source /homedtic/mwon/envs/amd/bin/activate
python -u main.py --architecture 'pons_won' \
  --conv_channels 16 \
  --batch_size 16 \
  --dataset 'msd' --data_type 'spec' \
  --data_path '/homedtic/mwon/dataset/msd' --model_save_path './../models/msd'
