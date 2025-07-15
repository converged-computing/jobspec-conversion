#!/bin/bash
#FLUX: --job-name=quick-models
#FLUX: --priority=16

set -o errexit
module load gcc/9.3.0
module load R/4.2.3
Rscript 02_naive.R $SLURM_ARRAY_TASK_ID
Rscript 03_complete_case.R $SLURM_ARRAY_TASK_ID
Rscript 07_true_model.R $SLURM_ARRAY_TASK_ID
