#!/bin/bash
#SBATCH --job-name=icarl_5
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=24GB
#SBATCH --time=12:00:00

if [ $# -ne 1 ]; then
  exit
fi
ml purge
ml PyTorch/0.4.0-gomkl-2018b-Python-2.7.15-CUDA-9.2.88
ml torchvision/0.2.1-gomkl-2018b-Python-2.7.15-CUDA-9.2.88 
echo 'Starting job'
python main.py "$1"
