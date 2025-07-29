#!/bin/bash
#FLUX: --job-name=slurmdemo
#FLUX: -t=120
#FLUX: --urgency=16

mkdir /tmp/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_out
cp *.py /tmp/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_out
cd /tmp/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_out
python ./slurmdemo.py worker
