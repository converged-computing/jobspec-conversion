#!/bin/bash
#FLUX: --job-name=buttery-dog-2289
#FLUX: --urgency=16

module purge
module load gcc/11.2.0
module load R/4.0.2
Rscript drat_combos.R $SLURM_ARRAY_TASK_ID
