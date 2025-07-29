#!/bin/bash
#SBATCH --output=log_%a.txt
#SBATCH --error=log_%s.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --array=0-20

echo "My SLURM_ARRAY_TASK_ID:" $SLURM_ARRAY_TASK_ID
python face_extraction.py $SLURM_ARRAY_TASK_ID
