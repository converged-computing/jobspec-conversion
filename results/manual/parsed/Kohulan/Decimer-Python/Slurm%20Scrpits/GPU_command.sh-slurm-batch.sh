#!/bin/bash
#SBATCH --mail-user=user@gmail.com
#SBATCH --mail-type=All
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --gres=gpu:1
#SBATCH --time=8-08:00:00
#SBATCH --qos=TOP
#SBATCH --no-requeue

module load nvidia/cuda/9 #loading Modules
module load tools/tensorflow/1.8.0
time python Cnn_modified_alexnet.py # Command to run the desired code
