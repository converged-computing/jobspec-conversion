#!/bin/bash
#SBATCH --output=log/%j-resnet101-ocr-contrast-40k-t0.07.out
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:4
#SBATCH --time=2-00:00:00

source /home/jc3/miniconda2/etc/profile.d/conda.sh
conda activate pytorch-0.4.1
module load gcc
module load cuda
sh run_r_101_d_8_ocrnet_train_contrast.sh train 'resnet101-ocr-contrast-40k'
