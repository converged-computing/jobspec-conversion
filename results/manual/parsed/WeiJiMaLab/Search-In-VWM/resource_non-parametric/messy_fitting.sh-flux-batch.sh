#!/bin/bash
#FLUX: --job-name=test
#FLUX: -t=270000
#FLUX: --urgency=16

module purge
module load matlab/R2013a
if [[ ! -z "$SLURM_ARRAY_TASK_ID" ]]; then
        IID=${SLURM_ARRAY_TASK_ID}
fi
cat<<EOF | matlab -nodisplay
addpath('/jukebox/scratch/aditis/bads-master/');
Master_Fitting($IID)
EOF
