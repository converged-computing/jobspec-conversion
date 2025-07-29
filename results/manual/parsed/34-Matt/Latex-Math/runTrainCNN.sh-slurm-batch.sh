#!/bin/bash
#SBATCH --job-name=TrainCNN
#SBATCH --output=out.txt
#SBATCH --error=err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --time=3-00:00:00

module purge
module load apps/python3
pip install --user --upgrade tensorflow
pip install tensorflow-gpu
pip install --user numpy
python TrainCNN.py
