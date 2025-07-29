#!/bin/bash
#SBATCH --job-name=low_bg_classifer
#SBATCH --output=low_bg_classifer.out
#SBATCH --error=low_bg_classifer.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --partition=gpu
#SBATCH --qos=high

echo "julia main.jl --lang bg --epochs 100 --dropouts 0.5 --modelType Classifier --optimizer 'Rmsprop(lr=1.0e-3, gclip=60)'"
julia main.jl --lang bg --epochs 100 --dropouts 0.5 --modelType Classifier --optimizer 'Rmsprop(lr=1.0e-3, gclip=60)'
