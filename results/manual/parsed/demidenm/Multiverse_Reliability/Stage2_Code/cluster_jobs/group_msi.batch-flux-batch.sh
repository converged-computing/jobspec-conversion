#!/bin/bash
#FLUX: --job-name=group_abcd
#FLUX: -c=4
#FLUX: --queue=agsmall,msismall
#FLUX: -t=1200
#FLUX: --urgency=16

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate fmri_env
ID=${SLURM_ARRAY_TASK_ID}
bash ./batch_jobs/group${ID}
