#!/bin/bash
#SBATCH --job-name=FredericMasterThesisGAN
#SBATCH --output=output_%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:1
#SBATCH --mem=2
#SBATCH --time=00:05:00

module load python/3.8.7
module load cuda/11.0
module load cudnn/8.0.5
pip3 install --user tensorflow
python3 trainer/TrainNeuralNetwork.py
