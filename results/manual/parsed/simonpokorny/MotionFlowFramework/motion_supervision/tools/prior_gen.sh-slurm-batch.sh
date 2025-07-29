#!/bin/bash
#SBATCH --output=logs/data_preprocess_%a.out
#SBATCH --error=logs/data_preprocess_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=40G
#SBATCH --time=3-00:00:00
#SBATCH --partition=amdlong
#SBATCH --constraint=ntasks-per-node=1

ml torchsparse
cd $HOME
python -u motion_supervision/preprocess_data.py $SLURM_ARRAY_TASK_ID
