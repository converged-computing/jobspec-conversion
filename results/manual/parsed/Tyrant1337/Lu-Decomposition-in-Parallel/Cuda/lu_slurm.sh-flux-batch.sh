#!/bin/bash
#FLUX: --job-name=gpucode              ### Job Name
#FLUX: --queue=short-gpu           ### do not change this parameter
#FLUX: --priority=16

/usr/local/cuda-8.0/bin/nvprof ./lu "$@"
echo '=====================JOB DIAGNOTICS========================'
date
echo -n 'This machine is ';hostname
echo -n 'My jobid is '; echo $SLURM_JOBID
echo 'My path is:' 
echo $PATH
echo 'My job info:'
squeue -j $SLURM_JOBID
echo 'Machine info'
sinfo -s
echo '========================ALL DONE==========================='
