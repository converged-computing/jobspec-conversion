#!/bin/bash
#SBATCH --account=sc3260
#SBATCH --output=mnist_cpu.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=10G
#SBATCH --time=20:00:00
#SBATCH --partition=maxwell

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest \
    python ./tutorials/image/mnist/convolutional.py
