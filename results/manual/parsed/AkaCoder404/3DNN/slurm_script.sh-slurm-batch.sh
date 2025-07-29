#!/bin/bash
#SBATCH --job-name=pointnet
#SBATCH --output=slurm_outputs/slurm-output-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=10:00:00
#SBATCH --partition=v100

python train.py --model pointnet_cls --dataset TUBerlin --epoch 500  --batch_size 32 --num_category 250
