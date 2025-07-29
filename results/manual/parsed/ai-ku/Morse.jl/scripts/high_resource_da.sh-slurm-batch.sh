#!/bin/bash
#SBATCH --job-name=high_da
#SBATCH --output=high_da.out
#SBATCH --error=high_da.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --partition=gpu
#SBATCH --qos=high

echo "julia main.jl --lang da --epochs 100 --dropouts 0.3"
julia main.jl --lang da --epochs 100 --dropouts 0.3
echo "julia main.jl --lang da --epochs 100 --lemma --dropouts 0.3"
julia main.jl --lang da --epochs 100 --lemma --dropouts 0.3
