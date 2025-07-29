#!/bin/bash
#SBATCH --job-name=usis
#SBATCH --output=usis%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=1
#SBATCH --mem=64G
#SBATCH --time=4-23:00:00

conda activate /anaconda3/envs/myenv
python train.py --name usis_wavelet --dataset_mode cityscapes --gpu_ids 0 \
--dataroot /data/public/cityscapes --batch_size 1  \
--netDu wavelet \
--model_supervision 0 --netG wavelet --channels_G 16
