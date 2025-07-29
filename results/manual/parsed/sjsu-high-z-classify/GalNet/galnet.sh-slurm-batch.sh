#!/bin/bash
#SBATCH --job-name=m2_valid
#SBATCH --output=m2_valid.out
#SBATCH --error=m2_valid.err
#SBATCH --mail-user=james.casey-clyde@sjsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=10-00:00:00
#SBATCH --partition=gpus

module purge
module load intel-python3
conda activate galnet
PYTHONHASHSEED=0 python galnet/galnet.py --train --model model-2
