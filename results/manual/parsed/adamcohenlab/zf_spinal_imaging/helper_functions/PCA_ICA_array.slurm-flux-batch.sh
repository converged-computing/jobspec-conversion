#!/bin/bash
#FLUX: --job-name=gloopy-peas-8770
#FLUX: --queue=shared
#FLUX: -t=1800
#FLUX: --urgency=16

module load matlab/R2018a-fasrc01
matlab -sd "~/" -nosplash -nodesktop -r "ICA_PCA_array($SLURM_ARRAY_TASK_ID)"
