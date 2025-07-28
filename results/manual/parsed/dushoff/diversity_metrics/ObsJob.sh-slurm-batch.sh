#!/bin/bash
#FLUX: --job-name=multisess
#FLUX: -c=2
#FLUX: --queue=main
#FLUX: -t=259200
#FLUX: --urgency=16

module load intel/17.0.4
module load R-Project/3.4.1
at=$SLURM_ARRAY_TASK_ID+1
srun Rscript scripts/obs_lomemSAD$at.R 
