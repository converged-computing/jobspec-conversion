#!/bin/bash
#SBATCH --job-name=pae_thin_spiral_train
#SBATCH --mail-user=<horvat@pyl.unibe.ch>
#SBATCH --mail-type=fail,end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:gtx1080ti:1
#SBATCH --mem=32G
#SBATCH --time=03:00:00
#SBATCH --qos=job_gpu

cd /storage/homefs/ch19g182/Python/Denoising-Normalizing-Flow-master/experiments
nvcc --version
nvidia-smi
python train.py  -c configs/train_pae_thin_spiral.config
