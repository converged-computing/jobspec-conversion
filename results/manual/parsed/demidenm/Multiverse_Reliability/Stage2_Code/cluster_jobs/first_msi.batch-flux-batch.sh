#!/bin/bash
#FLUX: --job-name=first_abcd
#FLUX: -c=6
#FLUX: --queue=msismall,agsmall
#FLUX: -t=14400
#FLUX: --urgency=16

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate fmri_env
module load fsl
ID=${SLURM_ARRAY_TASK_ID}
bash ./batch_jobs/first${ID}
