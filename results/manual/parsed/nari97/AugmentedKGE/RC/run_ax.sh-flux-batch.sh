#!/bin/bash
#FLUX: --job-name=reclusive-cherry-5190
#FLUX: -c=2
#FLUX: --queue=tier3
#FLUX: -t=7566
#FLUX: --urgency=16

folder=$1
echo " * Submitting job array..."
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
/home/crrvcs/ActivePython-3.7/bin/python3 -u ./Code/ax_async.py ${folder}
echo " Done with job array"
