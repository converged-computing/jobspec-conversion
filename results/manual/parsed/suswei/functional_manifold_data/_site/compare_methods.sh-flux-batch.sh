#!/bin/bash
#FLUX: --job-name="manifoldFDAgeodesic"
#FLUX: -c=8
#FLUX: --queue=cloud
#FLUX: -t=7200
#FLUX: --priority=16

i=${SLURM_ARRAY_TASK_ID}
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load MATLAB
R --vanilla < spartanSim.R
