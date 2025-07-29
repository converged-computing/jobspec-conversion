#!/bin/bash
#SBATCH --job-name=TransFAS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:A40:1
#SBATCH --mem=30G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

echo "Just checking!
Starting job on execution node : $(hostname)
Date: $(date)
Waiting ..."
echo "... Running"
python ~/code/Transfomer_FAS/train.py --config configs/OuluNPU.json -i tcp://localhost:12346
