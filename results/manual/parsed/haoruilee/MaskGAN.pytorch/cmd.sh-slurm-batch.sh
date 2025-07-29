#!/bin/bash
#SBATCH --job-name=maskgan
#SBATCH --account=jerin
#SBATCH --output=logs/%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=36
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=120gb

module load use.own
module load python/3.7.0
python3 -W ignore -m mgan.main --path datasets/aclImdb/ --spm_prefix datasets/aclImdb/train/imdb
