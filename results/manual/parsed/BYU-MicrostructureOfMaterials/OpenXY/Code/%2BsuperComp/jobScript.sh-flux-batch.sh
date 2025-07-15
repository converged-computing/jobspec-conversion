#!/bin/bash
#FLUX: --job-name=stanky-muffin-6649
#FLUX: --urgency=16

module add matlab/r2017b
matlab -nodisplay -nojvm -r "EBSDBatch($SLURM_ARRAY_TASK_ID)"
