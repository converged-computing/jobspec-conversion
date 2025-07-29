#!/bin/bash
#SBATCH --job-name=start_imge
#SBATCH --output=./logs/%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4

srun --mpi=pmi2 python -u main.py --config ./yaml/Inverse_ProGAN_GAN_MSGAN_ACGAN_start-with-image.yaml --mode train
