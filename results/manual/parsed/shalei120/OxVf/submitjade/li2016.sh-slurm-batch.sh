#!/bin/bash
#SBATCH --job-name=Vodafone
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=small

module load cuda/9.2
echo $PWD
python3 main.py -m li2016
