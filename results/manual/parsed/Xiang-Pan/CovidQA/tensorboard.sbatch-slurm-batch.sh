#!/bin/bash
#SBATCH --job-name=torch-test
#SBATCH --mail-user=xiangpan@nyu.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=7-00:00:00

MODEL_DIR="./outputs"
echo $(pwd)
tensorboard --logdir="${MODEL_DIR}" 
