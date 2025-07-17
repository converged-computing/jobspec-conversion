#!/bin/bash
#FLUX: --job-name=tabula_muris regularize_MMD
#FLUX: --queue=physical
#FLUX: -t=259200
#FLUX: --urgency=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load anaconda3/2020.07
source activate sharedenv
module load web_proxy
python3 regularize_MMD.py ${SLURM_ARRAY_TASK_ID}
