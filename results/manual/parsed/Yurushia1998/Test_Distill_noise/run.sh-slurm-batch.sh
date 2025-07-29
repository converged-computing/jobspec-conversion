#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=v100

set -e
set -x
CUDA_VISIBLE_DEVICES=0 python -m ieg.main --dataset=cifar10_uniform_0.8 --network_name=resnet29 --probe_dataset_hold_ratio=0.0002 --checkpoint_path=ieg/checkpoints/ieg 
