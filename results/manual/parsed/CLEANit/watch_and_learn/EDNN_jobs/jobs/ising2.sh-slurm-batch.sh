#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00

source activate tensorflow
module load cudnn/7.0-9.0
python EDNN.py ISING1 30 45 -l
