#!/bin/bash
#FLUX: --job-name=salted-cherry-2057
#FLUX: --priority=16

/opt/apps/MATLAB/R2012b/bin/matlab -nodisplay -r "PMType=$SLURM_ARRAY_TASK_ID;doChromaTest;quit"
