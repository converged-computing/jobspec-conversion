#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=log.out
#SBATCH --error=log.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=14000
#SBATCH --time=02:00:00

CUDA_VISIBLE_DEVICES=0,1,2,3
hostname
/usr/bin/nvidia-smi
. "/path/to/etc/profile.d/conda.sh"
conda activate project
python train.py -m sys3 -c 1000 --gpu_devices 0 1 2 3
python train.py -m sys5 -c 1000 -l checkpoints/sys5.43.upconv_xxxx.pyt --gpu_devices 0 1 2 3 
