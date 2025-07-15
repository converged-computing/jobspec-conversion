#!/bin/bash
#FLUX: --job-name=several_div
#FLUX: -c=6
#FLUX: --queue=main
#FLUX: -t=259200
#FLUX: --urgency=16

module load intel/17.0.4
module load R-Project/3.4.1
Rscript scripts/asy_SAD$SLURM_ARRAY_TASK_ID.R 
