#!/bin/bash
#SBATCH --account=StaMp
#SBATCH --output=./LogsTest/Ax_%A_%a.out
#SBATCH --error=./LogsTest/Ax_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=1024
#SBATCH --time=02:06:06
#SBATCH --partition=tier3

folder=$1
echo " * Submitting job array..."
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
/home/crrvcs/ActivePython-3.7/bin/python3 -u ./Code/ax_async.py ${folder}
echo " Done with job array"
