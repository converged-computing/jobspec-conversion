#!/bin/bash
#SBATCH --job-name=WaterLily
#SBATCH --account=research-me-mtt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=01:00:00

module load 2022r2
module load cuda/11.6
time julia TwoD_circle.jl
