#!/bin/bash
#SBATCH --job-name=smac
#SBATCH --output=./experiments/cluster_logs/%A_%a.o
#SBATCH --error=./experiments/cluster_logs/%A_%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --chdir=.
#SBATCH --array=0-499

source activate tensorflow-stable
PYTHONPATH=$PWD python optimizers/smac/run_smac.py --seed $SLURM_ARRAY_TASK_ID --search_space $1
