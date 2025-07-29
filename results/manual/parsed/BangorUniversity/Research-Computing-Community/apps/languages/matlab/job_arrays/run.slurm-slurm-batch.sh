#!/bin/bash
#FLUX: --job-name=job_arrays
#FLUX: --queue=htc
#FLUX: -t=1
#FLUX: --urgency=16

module purge
module load matlab/R2019a
matlab -nodisplay -r "func(${SLURM_ARRAY_TASK_ID});exit"
