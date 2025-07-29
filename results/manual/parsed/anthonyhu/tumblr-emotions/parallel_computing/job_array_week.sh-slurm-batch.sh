#!/bin/bash
#FLUX: --job-name=week_trend
#FLUX: --queue=medium
#FLUX: -t=43200
#FLUX: --urgency=16

python job_week.py
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
mkdir -p /data/ziz/not-backed-up/ahu/outputs/jobname_${SLURM_ARRAY_JOB_ID}
mkdir -p /data/ziz/not-backed-up/ahu/results/jobname_${SLURM_ARRAY_JOB_ID}
mv /data/localhost/not-backed-up/ahu/jobname_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.txt /data/ziz/not-backed-up/ahu/outputs/jobname_${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}.txt
