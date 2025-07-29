#!/bin/bash
#SBATCH --job-name=medical
#SBATCH --output=MRI%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=rtx_a5000:1
#SBATCH --mem=64G
#SBATCH --time=6-23:00:00
#SBATCH --qos=batch

pyenv activate venv
module load cuda
CUDA_VISIBLE_DEVICES=0 python train.py --name Wavelet_MRI_nomask --dataset_mode medicals --gpu_ids 0 \
--dataroot /misc/data/private/autoPET/CT_MR  \
--batch_size 4 --model_supervision 0  \
--Du_patch_size 32 --netDu wavelet  \
--netG 9 --channels_G 16   \
--num_epochs 500
