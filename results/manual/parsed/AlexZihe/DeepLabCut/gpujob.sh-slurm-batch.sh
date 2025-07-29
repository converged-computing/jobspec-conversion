#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00

module load gcc/6.2.0 cuda/9.0 python/3.6.0
source GPUIDpaw2/bin/activate
cd /home/zz90/DeepLabCut-100by100/pose-tensorflow/models/reachingJan30-trainset95shuffle1/train
python3 /home/zz90/DeepLabCut-100by100/pose-tensorflow/train.py
