#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

source activate pytorch_resnet
python_script=$1
job_num=$2
job_type=$3
lr=$4
DEBUG=1 python -u $python_script $job_num $job_type --hidden_size 1000 --num_hidden_layers 6 --lr $lr
