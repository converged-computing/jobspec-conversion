#!/bin/bash
#SBATCH --job-name=IoU
#SBATCH --account=kvd@gpu
#SBATCH --output=proj3d2d_%j.out
#SBATCH --error=proj3d2d_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=19:59:00
#SBATCH --constraint=ntasks-per-node=1

module purge
conda deactivate
module load pytorch-gpu/py3/1.7.1
CUDA_VISIBLE_DEVICES=0 python $WORK/code/semantic-segmentation/demo_folder.py --snapshot $WORK/code/semantic-segmentation/pretrained_models/kitti_best.pth
