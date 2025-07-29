#!/bin/bash
#SBATCH --job-name=grupo06-w3
#SBATCH --output=logs/%x_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16G
#SBATCH --chdir=/home/grupo06/
#SBATCH --array=56-63

source venv/bin/activate
python m3-project/w3/run.py m3-project/w3/config.ini ${SLURM_ARRAY_TASK_ID} --batch_size 256
