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
#SBATCH --partition=ILCC_GPU

CUDA_VISIBLE_DEVICES=0,1,2,3
hostname
/usr/bin/nvidia-smi
. "/path/to/etc/profile.d/conda.sh"
conda activate project
python train.py -m sys5_lang -c 1000 --gpu_devices 0 1 2 3
