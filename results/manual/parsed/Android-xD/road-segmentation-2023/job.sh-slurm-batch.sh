#!/bin/bash
#SBATCH --job-name=cil_train
#SBATCH --output=cil_train.out
#SBATCH --error=paperX.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=10:00:00

source startup.sh
python train.py
