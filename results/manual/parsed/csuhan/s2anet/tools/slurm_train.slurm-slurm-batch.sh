#!/bin/bash
#SBATCH --output=train_s2anet_r50_fpn_1x.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:4
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=4

module load scl/gcc4.9
module load nvidia/cuda/10.0
nvidia-smi
./tools/dist_train.sh \
  configs/dota/s2anet_r50_fpn_1x.py 4
