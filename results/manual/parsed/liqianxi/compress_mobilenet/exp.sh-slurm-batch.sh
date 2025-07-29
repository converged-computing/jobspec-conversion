#!/bin/bash
#SBATCH --account=def-qianxi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:01:00

module load python/3.9
source venv/bin/activate
python3.9 code/main.py
