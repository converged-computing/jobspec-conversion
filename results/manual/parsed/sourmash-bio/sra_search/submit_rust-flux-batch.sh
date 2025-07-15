#!/bin/bash
#FLUX: --job-name=evasive-lentil-1858
#FLUX: -t=360000
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
source ~/.bashrc
conda activate sra_search
set -o nounset
set -o errexit
set -x
snakemake -j 32 --use-conda -p
echo ${SLURM_JOB_NODELIST}       # Output Contents of the SLURM NODELIST
env | grep SLURM            # Print out values of the current jobs SLURM environment variables
scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits
