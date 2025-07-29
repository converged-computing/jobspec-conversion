#!/bin/bash
#SBATCH --job-name=ResNetBackbonesAllReID
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128G
#SBATCH --time=1-16:00:00
#SBATCH --partition=DEADLINE
#SBATCH --exclude=node14,node15,node16,node17,node18

source activate allreid_tv
python tools/train.py
