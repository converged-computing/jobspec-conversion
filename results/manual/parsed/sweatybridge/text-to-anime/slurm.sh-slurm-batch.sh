#!/bin/bash
#SBATCH --output=gpu-job-%j.output
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

export PYTHONUNBUFFERED='1'

module load cuda11.2/toolkit
cd ~/work/text-to-anime
. "/export/home/qiao002/miniconda3/etc/profile.d/conda.sh"
conda activate text-to-anime
export PYTHONUNBUFFERED=1
set -x
CUDA_VISIBLE_DEVICES=1 python train.py "$@"
