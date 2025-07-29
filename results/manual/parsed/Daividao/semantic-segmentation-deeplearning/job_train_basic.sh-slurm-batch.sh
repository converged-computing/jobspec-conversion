#!/bin/bash
#SBATCH --job-name=2dunet
#SBATCH --account=fc_biome
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00
#SBATCH --qos=savio_normal

module load python
module load tensorflow/1.10.0-py36-pip-gpu
module load cuda
python /global/scratch/dt111997/project/train_basic.py
