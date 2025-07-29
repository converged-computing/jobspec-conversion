#!/bin/bash
#SBATCH --job-name=wav2vec2phone
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=GPURAM_Min_12GB&GPURAM_Max_32GB
#SBATCH --array=8-23%3

echo "Activating environment wav2vec" > array_$SLURM_ARRAY_TASK_ID.txt
conda activate wav2vec
echo "Launching wav2vec2 array" >> array_$SLURM_ARRAY_TASK_ID.txt
python recipes/array-frozen/prepare_jobs.py $SLURM_ARRAY_TASK_ID
python recipes/array-frozen/recipe.py recipes/array-frozen/temp/$SLURM_ARRAY_TASK_ID/temp.yml >> array_$SLURM_ARRAY_TASK_ID.txt
