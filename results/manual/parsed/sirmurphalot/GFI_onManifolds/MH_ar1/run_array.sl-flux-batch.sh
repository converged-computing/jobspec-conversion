#!/bin/bash
#FLUX: --job-name=AR_sim
#FLUX: --queue=general
#FLUX: -t=172800
#FLUX: --urgency=16

module add matlab
matlab -nodesktop -nosplash -singleCompThread -r CMH_ar1 -logfile ./logfiles/testingArray_$SLURM_ARRAY_TASK_ID.out
