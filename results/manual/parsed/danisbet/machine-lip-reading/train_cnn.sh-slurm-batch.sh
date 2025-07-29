#!/bin/bash
#SBATCH --job-name=lipreading-train
#SBATCH --account=fc_mlsec
#SBATCH --mail-user=alex_vlissidis@berkeley.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=30G
#SBATCH --time=23:59:00

source deactivate
module purge
module load tensorflow/1.5.0-py35-pip-gpu
module unload cudnn/7.1
module load cudnn/7.0.5
python train_cnn.py
