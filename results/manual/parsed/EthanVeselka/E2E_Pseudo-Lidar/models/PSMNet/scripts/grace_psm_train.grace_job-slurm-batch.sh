#!/bin/bash
#SBATCH --job-name=grace_setup
#SBATCH --output=output.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=8G
#SBATCH --time=01:00:00

module load GCC/11.3.0
module load CUDA/11.7.0
module load OpenMPI/4.1.4
module load TensorFlow/2.11.0-CUDA-11.7.0
module load PyTorch/1.12.0-CUDA-11.7.0
module load OpenCV/4.6.0-contrib
module load scikit-learn/1.1.2
module load torchvision
sh predict.sh
