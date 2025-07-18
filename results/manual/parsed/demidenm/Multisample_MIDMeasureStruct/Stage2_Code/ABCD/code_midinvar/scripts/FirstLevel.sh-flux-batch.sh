#!/bin/bash
#FLUX: --job-name=first_projinv
#FLUX: -c=6
#FLUX: --queue=msismall,amdsmall
#FLUX: -t=1200
#FLUX: --urgency=16

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate fmri_env
module load fsl
ID=${SLURM_ARRAY_TASK_ID}
bash ./batch_run/first${ID}
