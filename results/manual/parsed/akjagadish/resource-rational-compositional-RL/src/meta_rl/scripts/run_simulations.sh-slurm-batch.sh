#!/bin/bash
#SBATCH --job-name=RL3
#SBATCH --output=./logs/tjob.out.%A_%a
#SBATCH --error=./logs/tjob.err.%A_%a
#SBATCH --mail-user=akshaykjagadish@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=1-16:00:00

cd ~/RL3NeurIPS/
module purge
conda activate pytorch-gpu
python simulate.py.py --entropy --prior svdo --num-episodes 400 --changepoint --per-trial 0
