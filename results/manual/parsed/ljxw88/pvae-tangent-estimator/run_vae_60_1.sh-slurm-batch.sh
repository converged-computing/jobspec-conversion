#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20GB
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

module load pytorch/1.4.0-py36-cuda90
module load torchvision/0.5.0-py36
python3 pvae/main.py --model mnist --manifold PoincareBall --c 0.1  --latent-dim 60 --hidden-dim 600 --prior WrappedNormal --posterior WrappedNormal --dec Geo     --enc Wrapped --lr 5e-4 --epochs 80 --save-freq 80 --batch-size 128 --iwae-samples 5000
