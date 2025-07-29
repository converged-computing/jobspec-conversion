#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=24G

d=$(date)
echo $d nvidia-smi
nvidia-smi
hostn=$(hostname -s)
cd /home/grad3/keisaito/domain_adaptation/AdaptSegNet
source activate pytorch
CUDA_VISIBLE_DEVICES=$1 python run_all.py --snapshot-dir ./snapshots/GTA2Cityscapes_single --lambda-seg 0.1 --gpu 1
