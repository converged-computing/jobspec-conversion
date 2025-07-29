#!/bin/bash
#SBATCH --job-name=tensorflow_gpu_demo
#SBATCH --output=tensorflow_gpu_demo.out.%J
#SBATCH --error=tensorflow_gpu_demo.err.%J
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30G

module load CUDA cuDNN anaconda
conda activate tensorflow-gpu
python multilayer_perceptron.py
