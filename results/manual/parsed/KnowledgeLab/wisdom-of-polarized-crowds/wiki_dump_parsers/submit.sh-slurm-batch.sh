#!/bin/bash
#SBATCH --job-name=wikiparser
#SBATCH --output=%A_%a.out
#SBATCH --error=%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=05:00:00

module add python
mapfile -t FILES < $1
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
python3 main.py $FILENAME $2 $3
