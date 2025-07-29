#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:titan-x:1
#SBATCH --mem=8G
#SBATCH --time=12:00:00

source activate tf
julia "$@"
