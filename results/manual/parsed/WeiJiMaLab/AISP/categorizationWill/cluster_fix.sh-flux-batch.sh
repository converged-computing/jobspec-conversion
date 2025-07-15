#!/bin/bash
#FLUX: --job-name=fixWill
#FLUX: -c=6
#FLUX: -t=172800
#FLUX: --priority=16

export MATLABPATH='$HOME/matlab-output'
export MATLAB_PREFDIR='$TMPDIR/.matlab/R2020b/'

index=$SLURM_ARRAY_TASK_ID
job=$SLURM_JOB_ID
ppn=$SLURM_JOB_CPUS_PER_NODE
module purge
module load matlab/2020b
export MATLABPATH=$HOME/matlab-output
export MATLAB_PREFDIR=$TMPDIR/.matlab/R2020b/
mkdir $TMPDIR/.matlab
cp -r $HOME/.matlab/R2020b $TMPDIR/.matlab/R2020b
mkdir $TMPDIR/.matlab/local_cluster_jobs
mkdir $TMPDIR/.matlab/local_cluster_jobs/R2020b
cat<<EOF | matlab -nodisplay
cd ~/AISP/categorizationWill
job_id = str2num(strjoin(regexp('$job','\d','match'), ''))
rng(job_id)
tmpfolder = sprintf('$TMPDIR/.matlab/local_cluster_jobs/R2020b', job_id)
mkdir(tmpfolder)
clust = parcluster();
clust.JobStorageLocation = tmpfolder;
parpool('threads')
cluster_fcn_fix(job_id);
EOF
