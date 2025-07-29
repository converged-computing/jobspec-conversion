#!/bin/bash
#SBATCH --job-name=mustard
#SBATCH --output=./output/%J.out
#SBATCH --error=./output/%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --partition=i64m1tga800u
#SBATCH --constraint=ntasks-per-node=4

module load cuda/11.8
bash run.sh
