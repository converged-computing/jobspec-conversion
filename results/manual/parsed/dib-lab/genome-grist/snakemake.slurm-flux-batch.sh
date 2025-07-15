#!/bin/bash
#FLUX: --job-name=fugly-itch-9445
#FLUX: --urgency=16

. ~/miniconda3/etc/profile.d/conda.sh
conda activate grist3
set -o nounset
set -o errexit
set -x
cd ~/genome-grist
genome-grist run conf-paper.yml -k --unlock -j 4
genome-grist run conf-paper.yml -k --resources mem_mb=210000 -j 32 summarize_tax summarize_gather summarize_mapping
env | grep SLURM            # Print out values of the current jobs SLURM environment variables
scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits
sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
