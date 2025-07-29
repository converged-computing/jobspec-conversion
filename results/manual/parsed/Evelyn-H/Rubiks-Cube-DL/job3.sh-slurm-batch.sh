#!/bin/bash
#SBATCH --job-name=RubiksDL3
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00

export PATH='$PATH:~/.local/bin'

export PATH=$PATH:~/.local/bin
module load python/3.6.0
cd ~/Rubiks-Cube-DL/
pipenv run python train.py --ini ini/cube3x3-zero-goal-decay-d50.ini -n run_${SLURM_JOBID}
