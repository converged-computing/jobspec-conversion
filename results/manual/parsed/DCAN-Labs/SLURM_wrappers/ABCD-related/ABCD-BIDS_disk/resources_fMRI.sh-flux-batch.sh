#!/bin/bash
#FLUX: --job-name=fMRI_ABCD-HCP
#FLUX: --queue=small,amdsmall
#FLUX: -t=43200
#FLUX: --urgency=16

cd run_files.fMRI
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
