#!/bin/bash
#SBATCH --job-name=slurmdemo
#SBATCH --output=slurmdemo_%A_%a.out
#SBATCH --error=slurmdemo_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00

mkdir /tmp/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_out
cp *.py /tmp/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_out
cd /tmp/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_out
python ./slurmdemo.py worker
