#!/bin/bash
#SBATCH --job-name=0318
#SBATCH --output=/hpc/data/home/bme/zhangzb1/Kaggle/HAT/slurm/0318.out
#SBATCH --error=/hpc/data/home/bme/zhangzb1/Kaggle/HAT/slurm/0318.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:NVIDIAA10080GBPCIe:1
#SBATCH --time=5-00:00:00

source ~/.bashrc
cd /hpc/data/home/bme/zhangzb1/Kaggle/HAT/hat
conda activate trans
nvidia-smi
python train.py -opt /hpc/data/home/bme/zhangzb1/Kaggle/HAT/options/train/train_HAT-L_SRx4_scratch_SR360_0318.yml
