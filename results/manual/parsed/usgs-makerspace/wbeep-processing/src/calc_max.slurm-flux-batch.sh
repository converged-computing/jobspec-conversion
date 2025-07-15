#!/bin/bash
#FLUX: --job-name=calc_max
#FLUX: -t=2700
#FLUX: --urgency=16

module load R/3.6.1
module load netcdf
srun Rscript src/calc_max.R
