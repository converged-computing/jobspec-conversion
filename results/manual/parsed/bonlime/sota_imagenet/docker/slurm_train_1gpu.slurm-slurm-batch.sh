#!/bin/bash
#SBATCH --job-name=imagenet experiments
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

python3 train.py loader.use_tfrecords=True val_loader.use_tfrecords=True +hydra_exp=$@
