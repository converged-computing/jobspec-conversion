#!/bin/bash
#SBATCH --job-name=daniil
#SBATCH --account=fc_deepmusic
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:2
#SBATCH --time=1-06:00:00
#SBATCH --partition=v100_gpu3_normal

module unload python/3.7
module load ml/tensorflow/2.5.0-py37 libsndfile
python train.py
