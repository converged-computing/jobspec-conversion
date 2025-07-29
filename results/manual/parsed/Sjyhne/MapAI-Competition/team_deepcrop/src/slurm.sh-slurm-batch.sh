#!/bin/bash
#SBATCH --job-name=seg
#SBATCH --mail-user=lilei@di.ku.dk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=4-15:00:00
#SBATCH --partition=gpu
#SBATCH --exclude=hendrixgpu09fl,hendrixgpu10fl,hendrixgpu11fl,hendrixgpu12fl,hendrixgpu13fl

hostname
echo $CUDA_VISIBLE_DEVICES
python train.py --task 2 --name deeplabv3_resnet50_withpreweight_combine_lidar --data_ratio 1.0
