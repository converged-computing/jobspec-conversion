#!/bin/bash
#SBATCH --job-name=FLJob
#SBATCH --output=/home/tangm_lab/cse12011439/codes/FLlab.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpulab02
#SBATCH --constraint=ntasks-per-node=6

nvcc -V
