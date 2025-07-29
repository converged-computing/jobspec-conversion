#!/bin/bash
#SBATCH --job-name=daniil
#SBATCH --account=fc_deepmusic
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --partition=savio2_gpu

module unload python/3.7
module load ml/tensorflow/2.3.0-py37 libsndfile
python train.py
