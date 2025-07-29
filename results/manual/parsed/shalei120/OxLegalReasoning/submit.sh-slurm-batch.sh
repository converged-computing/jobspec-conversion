#!/bin/bash
#SBATCH --job-name=Legal
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=5

module load python/anaconda3/2019.03
module load gpu/cuda/10.1.243
module load gpu/cudnn/7.5.0__cuda-10.0
echo "CUDA Device(s) : $CUDA_VISIBLE_DEVICES"
nvidia-smi
python3 main.py -m transformer
