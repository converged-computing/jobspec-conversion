#!/bin/bash
#SBATCH --output=logs/%x_%u_%j.out
#SBATCH --error=logs/%x_%u_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=4000

python coco_retrieval.py
