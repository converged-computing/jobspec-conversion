#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G

python ../scripts/python/save_feats.py $SLURM_ARRAY_TASK_ID
