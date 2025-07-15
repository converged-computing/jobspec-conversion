#!/bin/bash
#FLUX: --job-name=butterscotch-general-9107
#FLUX: --urgency=16

module load matlab/R2021a-fasrc01
matlab -nodisplay -nosplash -r "i_job=$SLURM_ARRAY_TASK_ID;binary_y_matlab;quit;"
