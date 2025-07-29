#!/bin/bash
#SBATCH --job-name=mnist
#SBATCH --account=cs678fl22
#SBATCH --output=mnist.%j.out
#SBATCH --error=mnist.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100.80gb:1
#SBATCH --mem=50GB
#SBATCH --time=02:00:00
#SBATCH --partition=gpuq
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=4

nvidia-smi
module load gnu10
module load python
./scripts/train_dlee.sh
./scripts/test_dlee.sh
