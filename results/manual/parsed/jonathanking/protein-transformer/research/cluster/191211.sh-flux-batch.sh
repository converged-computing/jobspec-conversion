#!/bin/bash
#FLUX: --job-name=tart-peas-8105
#FLUX: --queue=dept_gpu
#FLUX: -t=0
#FLUX: --urgency=16

work_dir=$(pwd)
user=$(whoami)
job_dir="${user}_${SLURM_JOB_ID}.dcb.private.net"
mkdir /scr/$job_dir
cd /scr/$job_dir
rsync -a ${work_dir}/* .
date>date-$SLURM_ARRAY_TASK_ID.txt
nvidia-smi
hostname>hostname-$SLURM_ARRAY_TASK_ID.txt
date>>date-$SLURM_ARRAY_TASK_ID.txt
rsync -ra *.log *.txt ${work_dir}
