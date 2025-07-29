#!/bin/bash
#FLUX: --job-name=LympIdent
#FLUX: -t=360000
#FLUX: --urgency=16

module load matlab/R2016b
matlab -nodisplay -r "fullLympIdent_TMA("$SLURM_ARRAY_TASK_ID");exit"
