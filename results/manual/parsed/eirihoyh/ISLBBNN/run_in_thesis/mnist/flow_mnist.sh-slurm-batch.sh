#!/bin/bash
#SBATCH --job-name=f_mnist
#SBATCH --output=/mnt/users/eirihoyh/mnist/log/mnist_flow_low_prior_prob_%j.out
#SBATCH --error=/mnt/users/eirihoyh/mnist/log/mnist_flow_low_prior_prob_%j.err
#SBATCH --mail-user=eirik.hoyheim@nmbu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=3G
#SBATCH --partition=gpu

module purge                # Clean all modules
module load Miniconda3
eval "$(conda shell.bash hook)"
conda activate skip_con
python flow_mnist.py
