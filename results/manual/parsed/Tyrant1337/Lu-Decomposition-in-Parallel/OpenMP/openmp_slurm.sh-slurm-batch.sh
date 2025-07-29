#!/bin/bash
#SBATCH --job-name=openmpcode
#SBATCH --output=slurm_output.%j
#SBATCH --error=slurm_error.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --time=00:01:00
#SBATCH --partition=day-long-cpu
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

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
