#!/bin/bash
#SBATCH --job-name=train_monuseg
#SBATCH --output=slurm-out/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem=20G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu

SWEEP_ID="5grn31dl"
module load any/python/3.8.3-conda
source env/bin/activate
wandb agent --project YOLOv5 --entity kaliuzhnyi --count 110 "$SWEEP_ID"
echo "DONE"
