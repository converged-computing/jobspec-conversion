#!/bin/bash
#FLUX: --job-name=ll%A
#FLUX: -N=4
#FLUX: -t=7200
#FLUX: --priority=16

ml purge
ml load R/3.5.1
ml load gcc/8.1.0
model_id=$1
params_id=$2
Rscript src/05_loo/compute_LL.R ${model_id} ${params_id} $SLURM_ARRAY_TASK_ID
