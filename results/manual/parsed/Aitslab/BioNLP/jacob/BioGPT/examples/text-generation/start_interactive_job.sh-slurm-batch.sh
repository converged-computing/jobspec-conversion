#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:30:00

export CUDA_LAUNCH_BLOCKING='1'

pwd
nvidia-smi
ml Anaconda/2021.05-nsc1
conda activate biogpt
export CUDA_LAUNCH_BLOCKING=1
python interactive.py --model_dir=../../checkpoints/Pre-trained-BioGPT --data_dir=../../data > jacob_test.txt
