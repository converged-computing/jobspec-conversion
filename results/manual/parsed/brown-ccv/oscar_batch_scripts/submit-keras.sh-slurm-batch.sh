#!/bin/bash
#SBATCH --job-name=MyKerasJob
#SBATCH --output=KerasJob.out
#SBATCH --error=KerasJob.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:30:00

module load keras/2.0.9
module load cuda/8.0.61 cudnn/5.1 tensorflow/1.1.0_gpu
python mnist_cnn.py
