#!/bin/bash
#SBATCH --job-name=noisy_small_1
#SBATCH --account=project_2003370
#SBATCH --output=./err_out/out_task_number_%A_%a.txt
#SBATCH --error=./err_out/err_task_number_%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:a100:1
#SBATCH --time=01:40:00
#SBATCH --array=1-10

echo $SLURM_ARRAY_TASK_ID
module load pytorch/1.11
python train.py -p config/params.yaml -alpha $SLURM_ARRAY_TASK_ID
