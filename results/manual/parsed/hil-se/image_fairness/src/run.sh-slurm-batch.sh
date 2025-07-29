#!/bin/bash
#SBATCH --job-name=image_fairness
#SBATCH --account=loop
#SBATCH --output=log/%J.o
#SBATCH --error=log/%J.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=3-03:05:03

spack unload -a
spack load /lklqe3u
spack load /saj4vss
spack load py-pandas
python3 main.py nofair 10
