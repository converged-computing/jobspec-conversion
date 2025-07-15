#!/bin/bash
#FLUX: --job-name=myTest
#FLUX: -t=7200
#FLUX: --priority=16

export MATLABPATH='$HOME/matlab-output'

index=$SLURM_ARRAY_TASK_ID
job=$SLURM_JOB_ID
ppn=$SLURM_JOB_CPUS_PER_NODE
module purge
module load matlab/2018b
export MATLABPATH=$HOME/matlab-output
cat<<EOF | matlab -nodisplay
job_id = str2num(strjoin(regexp('$job','\d','match'), ''))
rng(job_id)
addpath(genpath('$HOME/AISP'))
newdir = '$SCRATCH/cluster$job';
mkdir(newdir);
cluster_fcn(job_id,$index);
rmdir(newdir,'s')
EOF
