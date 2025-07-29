#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:12:00

module load tensorflow/1.8-agave-gpu
cd /home/tgokhale/work/code/Arrangement_Classification
python3 train.py
