#!/bin/bash
#FLUX: --job-name=persnickety-poo-2858
#FLUX: --urgency=16

module load matlab/R2018a-fasrc01
matlab -sd "~/" -nosplash -nodesktop -r "ICA_PCA_array($SLURM_ARRAY_TASK_ID)"
