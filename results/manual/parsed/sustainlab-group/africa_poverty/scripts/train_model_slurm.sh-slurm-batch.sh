#!/bin/bash
#FLUX: --job-name={SLURM_JOB_NAME}
#FLUX: -c=10
#FLUX: --queue=atlas
#FLUX: -t=86400
#FLUX: --urgency=16

echo "
Slurm Environment Variables:
- SLURM_JOBID=$SLURM_JOBID
- SLURM_JOB_NODELIST=$SLURM_JOB_NODELIST
- SLURM_NNODES=$SLURM_NNODES
- SLURMTMPDIR=$SLURMTMPDIR
- SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR
"
source ~/.bashrc
project_dir="/atlas/u/chrisyeh/africa_poverty/"
echo "Setting directory to: $project_dir"
cd $project_dir
echo "
Basic system information:
- Date: $(date)
- Hostname: $(hostname)
- User: $USER
- pwd: $(pwd)
"
conda activate py37
{content}
echo "All jobs launched!"
echo "Waiting for child processes to finish..."
wait
echo "Done!"
