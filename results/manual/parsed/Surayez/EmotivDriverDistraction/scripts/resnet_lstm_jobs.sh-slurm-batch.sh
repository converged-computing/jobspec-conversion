#!/bin/bash
#SBATCH --job-name=ResNet_LSTM
#SBATCH --account=hz18
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --partition=m3f

problem=Emotiv266
model=resnet_lstm
cd ..
python3 compare_models.py -p Emotiv266 -c $model -i 5
