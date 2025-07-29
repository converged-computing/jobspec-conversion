#!/bin/bash
#SBATCH --job-name=cw
#SBATCH --account=COMS030144
#SBATCH --output=./bc4_out/log_%j.out
#SBATCH --error=./bc4_out/log_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=16GB
#SBATCH --time=03:00:00
#SBATCH --partition=teach_gpu

mkdir -p ./bc4_out
module purge
module load "languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch"
python3 main.py --epochs 10 --learning-rate 0.2 --sgd-momentum 0.93 --op sgd --model ChunkResCNN1 --conv-length 256 --conv-stride 256
