#!/bin/bash
#SBATCH --job-name=resnet50_pretraining
#SBATCH --account=jiaoyuling
#SBATCH --output=out.log
#SBATCH --error=err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:4
#SBATCH --constraint=ntasks-per-node=1

PYTHON_PATH=/home/mawensen/project/miniconda3/envs/torch/bin
$PYTHON_PATH/python -u train.py
