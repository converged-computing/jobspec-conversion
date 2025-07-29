#!/bin/bash
#SBATCH --job-name=HSeg_original
#SBATCH --output=/home/dpere013/MeshCNN/outputs/human_seg_original.txt
#SBATCH --mail-user=dpere013@odu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

enable_lmod
module load python/3.6
module load cuda/9.2
module load pytorch/1.0
python train.py \
--dataroot datasets/human_seg \
--name human_seg_original \
--arch meshunet \
--dataset_mode segmentation \
--ncf 32 64 128 256 \
--ninput_edges 2280 \
--pool_res 1800 1350 600 \
--resblocks 3 \
--batch_size 12 \
--lr 0.001 \
--num_aug 20 \
--slide_verts 0.2 \
