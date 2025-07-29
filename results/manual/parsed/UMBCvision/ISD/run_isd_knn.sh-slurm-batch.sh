#!/bin/bash
#SBATCH --job-name=knn_isd_3
#SBATCH --account=pi_hpirsiav
#SBATCH --output=logs/knn_isd_3.txt
#SBATCH --error=logs/knn_isd_3.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:4
#SBATCH --mem=100G
#SBATCH --time=20:00:00
#SBATCH --partition=gpu
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

set -x
set -e
for exp_dir in output/isd_3_*_resnet18
do
    python eval_knn.py \
        -j 16 \
        -b 256 \
        --arch resnet18 \
        --weights $exp_dir/ckpt_epoch_200.pth \
        --save $exp_dir \
        /nfs/ada/hpirsiav/datasets/imagenet
done
