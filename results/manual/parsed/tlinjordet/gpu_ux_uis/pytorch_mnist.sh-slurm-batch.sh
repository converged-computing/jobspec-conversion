#!/bin/bash
#SBATCH --job-name=pytorch_mnist
#SBATCH --output=mnist_test_01.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=02:15:00
#SBATCH --partition=gpuA100

uenv verbose cuda-11.4 cudnn-11.4-8.2.4
uenv miniconda-python39
conda activate pytorch_env
python -u pytorch_mnist.py
