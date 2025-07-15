#!/bin/bash
#FLUX: --job-name=eccentric-dog-6968
#FLUX: --urgency=16

/opt/apps/MATLAB/R2012b/bin/matlab -nodisplay -r "PMType=$SLURM_ARRAY_TASK_ID;doChromaTest;quit"
