#!/bin/bash
#SBATCH --output=BCSS_CENet_2.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

python -u train_unet_hist.py -g 0 -b 4 -d BCSS -m CENet -f 2
