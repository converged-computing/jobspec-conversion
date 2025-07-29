#!/bin/bash
#SBATCH --output=logs/argo2_%a.out
#SBATCH --error=logs/argo2_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

ml torchsparse
cd $HOME
python -u my_datasets/argoverse/argoverse2.py $SLURM_ARRAY_TASK_ID
