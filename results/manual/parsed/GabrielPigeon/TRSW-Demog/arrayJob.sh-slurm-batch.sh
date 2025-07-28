#!/bin/bash
#FLUX: --job-name=v4Cost
#FLUX: -t=519835
#FLUX: --urgency=16

module load r/4.1.2
cd ~/projects/def-pelleti2/pigeonga/Trsw_justine/
Rscript --verbose R/4_runModel.R $SLURM_JOB_NAME $SLURM_ARRAY_TASK_ID
