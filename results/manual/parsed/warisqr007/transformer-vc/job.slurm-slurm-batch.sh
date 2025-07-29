#!/bin/bash
#SBATCH --job-name=dl-hw2
#SBATCH --output=PINNs_5_500.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx:1
#SBATCH --mem=32G
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=48

module load GCC/10.2.0
module load CUDA/11.1.1
module load OpenMPI/4.0.5
module load PyTorch/1.10.0
module load Anaconda3/2021.11
module load Anaconda3/2021.11
cd /scratch/user/bhanu/dl_hw2/ResNet
python main.py
