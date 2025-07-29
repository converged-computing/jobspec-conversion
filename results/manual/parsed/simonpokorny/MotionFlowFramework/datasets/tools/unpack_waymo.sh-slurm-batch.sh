#!/bin/bash
#SBATCH --output=logs/waymo_%a.out
#SBATCH --error=logs/waymo_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=30G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

ml torchsparse
cd $HOME
python -u my_datasets/waymo/waymo.py $SLURM_ARRAY_TASK_ID
