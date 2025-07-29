#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=./logs/colorization-autoencoder.out
#SBATCH --error=./logs/colorization-autoencoder.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=1-00:00:00

source scripts/startup.sh
cd third_party/colorization-autoencoder
python train.py --train_list "perseverance_navcam_color" --parallel 0 --batch-size 32 -j 1 --pth-save-fold "/cluster/scratch/horatan/mars/results" --epochs 100
