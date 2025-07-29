#!/bin/bash
#SBATCH --job-name=DrBERT
#SBATCH --account=rtl@v100
#SBATCH --output=./logs/%x_%A_%a.out
#SBATCH --error=./logs/%x_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --time=19:00:00
#SBATCH --partition=gpu_p2
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=ntasks-per-node=1

module purge
module load pytorch-gpu/py3/1.11.0
nvidia-smi
srun python build_tokenizer.py
