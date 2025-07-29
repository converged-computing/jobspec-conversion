#!/bin/bash
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=7-01:36:00

module load cuda cudnn
source /home/edonovan/tensorflow/bin/activate
python train.py
