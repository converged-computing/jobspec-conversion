#!/bin/bash
#SBATCH --job-name=pytorch_example
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00
#SBATCH --partition=v100

jupyter notebook --ip=0.0.0.0 --port=3001 --no-browser
