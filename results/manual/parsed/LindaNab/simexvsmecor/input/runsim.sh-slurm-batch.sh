#!/bin/bash
#FLUX: --job-name=simexvsmecor
#FLUX: -t=360000
#FLUX: --urgency=16

scenario=${SLURM_ARRAY_TASK_ID}
module purge
module add statistical/R/4.0.2/gcc.8.3.1
Rscript --vanilla ./input/output.R 197 $scenario "./output/"
