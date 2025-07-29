#!/bin/bash
#SBATCH --job-name=connoisseur
#SBATCH --output=output.txt
#SBATCH --error=errors.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=sched_mit_sloan_gpu

module load python/3.6.3
module load sloan/python/modules/python-3.6/tensorflow/1.9.0/gpu
python3.6 main.py
