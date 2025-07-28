#!/bin/bash
#FLUX: --job-name=sra_search
#FLUX: -c=32
#FLUX: --queue=bmm
#FLUX: -t=360000
#FLUX: --urgency=16

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
