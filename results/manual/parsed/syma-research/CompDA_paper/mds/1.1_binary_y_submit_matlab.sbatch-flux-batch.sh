#!/bin/bash
#FLUX: --job-name=arid-cherry-9575
#FLUX: --priority=16

module load matlab/R2021a-fasrc01
matlab -nodisplay -nosplash -r "i_job=$SLURM_ARRAY_TASK_ID;binary_y_matlab;quit;"
