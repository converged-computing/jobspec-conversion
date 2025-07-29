#!/bin/bash
#SBATCH --job-name=w4
#SBATCH --output=logs/%x_%u_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16G
#SBATCH --qos=masterlow
#SBATCH --chdir=/home/grupo06/
#SBATCH --array=101-200

source venv/bin/activate
python m3-project/w4/train.py ${SLURM_ARRAY_TASK_ID}
