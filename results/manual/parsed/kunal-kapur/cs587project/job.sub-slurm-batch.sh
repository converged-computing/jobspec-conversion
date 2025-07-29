#!/bin/bash
#SBATCH --account=gpu
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

module load anaconda/2020.11-py38
source activate cs587
python avazu_train.py -cross_layers 1 -stacked True
python avazu_train.py -cross_layers 2 -stacked True
python avazu_train.py -cross_layers 1 -reg 0.1
python avazu_train.py -cross_layers 1 -reg 0.01
python avazu_train.py -cross_layers 1 -reg 0.001
