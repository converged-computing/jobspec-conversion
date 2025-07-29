#!/bin/bash
#SBATCH --job-name=rad-training
#SBATCH --account=bii_dsc_community
#SBATCH --output=%u-%j-rad-train.out
#SBATCH --error=%u-%j-rad-train.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=256G
#SBATCH --time=3-00:00:00
#SBATCH --array=0-3

date
nvidia-smi
source env.sh
python training.py --rad --id $SLURM_ARRAY_TASK_ID --n 1534
