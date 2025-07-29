#!/bin/bash
#SBATCH --job-name=gpt_test
#SBATCH --account=def-rgmelko
#SBATCH --output=gpt_test-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000M
#SBATCH --time=01:00:00

module purge
module load python/3.10
python rydberg_rnn.py
