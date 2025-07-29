#!/bin/bash
#SBATCH --job-name=eeg_proc
#SBATCH --output=./slurm/output%j.txt
#SBATCH --error=./slurm/error%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=200000M
#SBATCH --time=00:11:59
#SBATCH --partition=gpu_v100_2

nvidia-smi
conda env list
spack load cuda/gypzm3r
spack load cudnn
source activate torchpip
srun python3 ../SlitCNNModels/eeg.py
