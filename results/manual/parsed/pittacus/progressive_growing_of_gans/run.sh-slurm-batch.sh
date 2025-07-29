#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:$GPU_COUNT
#SBATCH --mem=128G

GPU_COUNT=$(grep -Po "^[^\#].+gpus = \K([0-9]+)" config.py)
echo $(hostname) $CUDA_VISIBLE_DEVICES $GPU_COUNT
singularity exec /public/DL_Data/cnic_ai.img python train.py
