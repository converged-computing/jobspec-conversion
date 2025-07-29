#!/bin/bash
#SBATCH --output=supercloud_logs/%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:volta:1

export OMP_NUM_THREADS='20'
export IMAGENET_PATH='/home/gridsan/groups/datasets/ImageNet'

source /etc/profile
module load anaconda/2023a
export OMP_NUM_THREADS=20
export IMAGENET_PATH=/home/gridsan/groups/datasets/ImageNet
python main.py --train_bs 128 --test_bs 128 --arch resnet50 --dataset imagenet --epochs 500
