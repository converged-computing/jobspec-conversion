#!/bin/bash
#FLUX: --job-name=chocolate-kerfuffle-3287
#FLUX: --priority=16

module add matlab/r2017b
matlab -nodisplay -nojvm -r "EBSDBatch($SLURM_ARRAY_TASK_ID)"
