#!/bin/bash
#SBATCH --account=es_sachan
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=a100_80gb:1
#SBATCH --mem-per-cpu=16384
#SBATCH --time=1-00:00:00

module load eth_proxy
module load gcc/9.3.0
module load cuda/11.7.0
conda activate thesis
python3 toy_test.py
