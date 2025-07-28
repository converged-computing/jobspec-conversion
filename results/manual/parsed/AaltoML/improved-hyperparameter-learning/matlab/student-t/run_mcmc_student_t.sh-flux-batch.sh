#!/bin/bash
#FLUX: --job-name=placid-pedo-8517
#FLUX: -t=172800
#FLUX: --urgency=16

mkdir -p result
matlab -r "mcmc_student_t($SLURM_ARRAY_TASK_ID)"
