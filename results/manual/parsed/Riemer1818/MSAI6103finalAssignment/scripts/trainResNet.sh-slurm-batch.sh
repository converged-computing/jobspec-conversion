#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --output=output_%x_%j.out
#SBATCH --error=error_%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=6G
#SBATCH --qos=q_amsai

module load anaconda3/23.5.2
eval "$(conda shell.bash hook)"
conda activate pytorch-CycleGAN-and-pix2pix
python train.py --dataroot ./datasets/cityscapes --name cityscapes_pix2pix_ResNet --model pix2pix --direction BtoA --display_id -1 --loss resnet --save_epoch_freq 50
