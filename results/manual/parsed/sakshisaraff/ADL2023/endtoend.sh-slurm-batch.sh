#!/bin/bash
#SBATCH --job-name=coursework
#SBATCH --account=COMS030144
#SBATCH --output=./log_%j.out
#SBATCH --error=./log_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=06:00:00

module purge
module add python
module load python
module load "languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch"
