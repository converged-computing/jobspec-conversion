#!/bin/bash
#FLUX: --job-name=nullsim
#FLUX: -c=4
#FLUX: -t=2400
#FLUX: --urgency=16

cd /mmfs1/data/kurkela/Desktop/CamCan/code
module load matlab
matlab -nodisplay -nosplash -r "D_cbpm_nullsim('memoryability', 'all', 'default', 0.01, 'none', $SLURM_ARRAY_TASK_ID);"
