#!/bin/bash
#SBATCH --job-name=Facke_CVAE_New_Generator
#SBATCH --output=log.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=10-10:00:00

module load anaconda3/2019.07
source activate pytorch_1.11
python -u ./train_CVAE.py --model CVAE --batchSize 32 --name CVAE_GAN --display_freq 2000 --no_intra_ID_random --print_freq 2400
