#!/bin/bash
#FLUX: --job-name=crusty-itch-3105
#FLUX: -t=172800
#FLUX: --urgency=16

mkdir -p result
matlab -r "mcmc_student_t($SLURM_ARRAY_TASK_ID)"
