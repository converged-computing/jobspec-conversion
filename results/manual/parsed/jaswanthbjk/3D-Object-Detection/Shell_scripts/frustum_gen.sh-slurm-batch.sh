#!/bin/bash
#SBATCH --job-name=frustum-Pointnet
#SBATCH --output=/home/jbandl2s/train.%j.out
#SBATCH --error=/home/jbandl2s/train.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=32

module load cuda
cd /home/jbandl2s/RnD/frustum-pointnets
python kitti/prepare_data.py --gen_val_rgb_detection
