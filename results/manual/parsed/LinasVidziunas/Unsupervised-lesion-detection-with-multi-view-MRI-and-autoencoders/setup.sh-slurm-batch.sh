#!/bin/bash
#SBATCH --job-name=setup
#SBATCH --output=setup.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --time=02:00:00

uenv verbose cuda-11.4 cudnn-11.4-8.2.4
python3 -m pip install -r requirements.txt --user
