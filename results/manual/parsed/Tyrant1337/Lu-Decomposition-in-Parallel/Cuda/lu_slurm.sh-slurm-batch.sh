#!/bin/bash
#SBATCH --job-name=gpucode
#SBATCH --output=slurm_output.%j
#SBATCH --error=slurm_error.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:P100_SXM:4
#SBATCH --mem=30G

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
