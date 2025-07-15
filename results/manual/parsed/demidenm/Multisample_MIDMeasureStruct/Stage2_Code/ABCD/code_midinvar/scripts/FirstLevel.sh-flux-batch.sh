#!/bin/bash
#FLUX: --job-name=anxious-puppy-9754
#FLUX: -c=6
#FLUX: --priority=16

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate fmri_env
module load fsl
ID=${SLURM_ARRAY_TASK_ID}
bash ./batch_run/first${ID}
