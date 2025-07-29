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
#SBATCH --partition=ml4good
#SBATCH --exclude=hendrixgpu09fl,hendrixgpu10fl,hendrixgpu11fl,hendrixgpu12fl,hendrixgpu13fl

hostname
echo $CUDA_VISIBLE_DEVICES
echo "try for using the tverskyloss"s
python train_ConvNet.py --task 1 --name convNext_croloss --data_ratio 1.0 --config config/data_conv.yaml --lr 1e-2
