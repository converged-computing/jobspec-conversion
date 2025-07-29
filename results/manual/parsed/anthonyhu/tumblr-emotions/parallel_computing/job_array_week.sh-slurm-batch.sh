#!/bin/bash
#SBATCH --job-name=week_trend
#SBATCH --output=/data/localhost/not-backed-up/ahu/jobname_%A_%a.txt
#SBATCH --mail-user=ahu@stats.ox.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32000
#SBATCH --time=12:00:00
#SBATCH --array=0-0%1

python job_week.py
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
mkdir -p /data/ziz/not-backed-up/ahu/outputs/jobname_${SLURM_ARRAY_JOB_ID}
mkdir -p /data/ziz/not-backed-up/ahu/results/jobname_${SLURM_ARRAY_JOB_ID}
mv /data/localhost/not-backed-up/ahu/jobname_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.txt /data/ziz/not-backed-up/ahu/outputs/jobname_${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}.txt
