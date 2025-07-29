#!/bin/bash
#SBATCH --job-name=ms
#SBATCH --output=logs/ms_run_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=05:00:00

conda activate ms-gen
echo "Cuda visible:"
echo $CUDA_VISIBLE_DEVICES
eval $CMD
