#!/bin/bash
#FLUX: --job-name=confused-mango-0965
#FLUX: -c=4
#FLUX: --urgency=16

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate fmri_env
ID=${SLURM_ARRAY_TASK_ID}
bash ./batch_jobs/group${ID}
