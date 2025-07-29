#!/bin/bash
#SBATCH --job-name=godcaster_whisper
#SBATCH --account=ia1
#SBATCH --output=out.godcaster_whisper.log
#SBATCH --error=err.godcaster_whisper.log
#SBATCH --mail-user=kxu39@jhu.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=48000
#SBATCH --time=6-00:00:00
#SBATCH --qos=normal
#SBATCH --array=0-9

cd godcaster
cd src/captions
poetry run python main.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_MAX 
