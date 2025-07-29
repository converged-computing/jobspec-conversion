#!/bin/bash
#SBATCH --job-name=task2
#SBATCH --output=task2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=00:30:00

cd $SLURM_SUBMIT_DIR
module load nvidia/cuda/11.8
nvcc task2.cu scan.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task2
./task2 10 1024
