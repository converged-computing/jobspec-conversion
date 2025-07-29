#!/bin/bash
#SBATCH --job-name=JetsTrain%j
#SBATCH --output=slurm_out/JetsTrain%j.out
#SBATCH --error=slurm_out/JetsTrain%j.err
#SBATCH --mail-user=henrion@nyu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12000

PYTHONARGS="$@"
PYTHONARGS="$PYTHONARGS --slurm --gpu 0 --slurm_array_job_id $SLURM_ARRAY_JOB_ID --slurm_array_task_id $SLURM_ARRAY_TASK_ID"
cd $SRCDIR/src/scripts/
python eval.py $PYTHONARGS
