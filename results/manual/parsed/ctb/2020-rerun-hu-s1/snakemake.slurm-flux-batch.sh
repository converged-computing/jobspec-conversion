#!/bin/bash
#FLUX: --job-name=hu-s1
#FLUX: -c=8
#FLUX: --queue=bmm
#FLUX: -t=172800
#FLUX: --urgency=16

. ~/miniconda3/etc/profile.d/conda.sh
conda activate sgc
set -o nounset
set -o errexit
set -x
cd ~/2020-rerun-hu
snakemake --use-conda -j 8 -k --unlock
snakemake --use-conda -j 8 -k
env | grep SLURM            # Print out values of the current jobs SLURM environment variables
scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits
sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
