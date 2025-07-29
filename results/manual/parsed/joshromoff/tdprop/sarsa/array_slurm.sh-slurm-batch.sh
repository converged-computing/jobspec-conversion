#!/bin/bash
#SBATCH --output=logs/slurm/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=8g
#SBATCH --time=08:00:00
#SBATCH --array=0-599

module load pytorch
python main_sarsa.py --array_name=Jun6_10M --array_id=$SLURM_ARRAY_TASK_ID 
