#!/bin/bash
#SBATCH --job-name=train
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --time=8-00:00:00
#SBATCH --partition=defq
#SBATCH --constraint=ntasks-per-node=8

module load cuda11.0/toolkit/11.0.3
python tools/train.py -f exps/example/custom/cfp_s.py -d 1 -b 16 --fp16 -o -c ./weights/cfp_s.pth
