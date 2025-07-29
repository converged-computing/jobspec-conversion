#!/bin/bash
#FLUX: --job-name=openmpcode
#FLUX: -c=48
#FLUX: --exclusive
#FLUX: --queue=day-long-cpu
#FLUX: -t=60
#FLUX: --urgency=16

export OMP_PROC_BIND='close'

export OMP_PROC_BIND='close'
echo ' thread affinity/proc_bind = ' ; echo $OMP_PROC_BIND
./lud_openMPpar "$@"
echo '=====================JOB DIAGNOTICS========================'
date
echo -n 'This machine is ';hostname
echo -n 'My jobid is '; echo $SLURM_JOBID
echo 'My path is:' 
echo $PATH
sinfo -s
echo 'My job info:'
squeue -j $SLURM_JOBID
echo 'Machine info'
echo ' '
echo '========================ALL DONE==========================='
