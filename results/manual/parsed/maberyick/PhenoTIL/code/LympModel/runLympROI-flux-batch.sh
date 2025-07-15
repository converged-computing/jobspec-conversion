#!/bin/bash
#FLUX: --job-name=LympIdentROI
#FLUX: -t=3600
#FLUX: --priority=16

module load matlab/R2016b
matlab -nodisplay -r "fullLympIdent_ROI("$SLURM_ARRAY_TASK_ID");exit"
