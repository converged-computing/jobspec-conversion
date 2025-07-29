#!/bin/bash
#SBATCH --job-name=Unet
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpulab02
#SBATCH --qos=gpulab02
#SBATCH --constraint=ntasks-per-node=6

nvidia-smi
python3 script_train.py --datadir ../datasets/cityscapes --batch_size 4 --num_gpu 1 --losstype segment
