#!/bin/bash
#SBATCH --output=sbatch_run.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=12G

module load pytorch1.0-cuda9.0-python3.6
python main.py --cuda
