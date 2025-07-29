#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=09:00:00

export THEANO_FLAGS='device=gpu'

export THEANO_FLAGS="device=gpu"
source ~/.myworkrc
source activate py3
source ~/.cudarc_new
python --version
nvcc --version
dev=$(nvidia-smi |grep "0%" -B1|awk '{print $2}'|head -n 1)
echo $dev
CUDA_VISIBLE_DEVICES=$dev python cli.py train $* --budget-secs=28800
