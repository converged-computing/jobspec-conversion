#!/bin/bash
#FLUX: --job-name=drat_combos
#FLUX: -c=8
#FLUX: --queue=shared
#FLUX: -t=604800
#FLUX: --urgency=16

module purge
module load gcc/11.2.0
module load R/4.0.2
Rscript drat_combos.R $SLURM_ARRAY_TASK_ID
