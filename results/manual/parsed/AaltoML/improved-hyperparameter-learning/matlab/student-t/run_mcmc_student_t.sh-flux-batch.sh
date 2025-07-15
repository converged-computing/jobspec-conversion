#!/bin/bash
#FLUX: --job-name=swampy-cinnamonbun-3919
#FLUX: -t=172800
#FLUX: --priority=16

mkdir -p result
matlab -r "mcmc_student_t($SLURM_ARRAY_TASK_ID)"
