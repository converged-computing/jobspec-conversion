#!/bin/bash
#SBATCH --job-name=pytorch_BLOCKATTENTION
#SBATCH --output=/OSM/CBR/AF_WQ/source/ML/Log/Pytorch/Pytorch_BLOCKATTENTION__%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=08:00:00

module load cuda/9.0.176
module load pytorch/1.1.0-py36-cuda90
python Pytorch_Seq2Seq/main.py
