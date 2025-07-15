#!/bin/bash
#FLUX: --job-name="bat1"
#FLUX: --priority=16

export PATH='/expanse/lustre/scratch/jpg/temp_project/matlab_2020b/bin:$PATH'

countries=( UA  )
export PATH=/expanse/lustre/scratch/jpg/temp_project/matlab_2020b/bin:$PATH
mkdir -p .matlab/local_cluster_jobs/R2019b/$SLURM_JOB_ID
module load matlab
matlab -nodisplay -r "Run_ABC('${countries[$SLURM_ARRAY_TASK_ID]}',1);exit"
rm -rf .matlab/local_cluster_jobs/R2019b/$SLURM_JOB_ID
