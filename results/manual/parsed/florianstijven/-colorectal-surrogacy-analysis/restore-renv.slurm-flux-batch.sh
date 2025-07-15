#!/bin/bash
#FLUX: --job-name=meta-TCT-simulations
#FLUX: -c=2
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module use /apps/leuven/rocky8/icelake/2022b/modules/all
module load GSL
module load CMake
module load  R/4.3.2-foss-2022b
Rscript -e "renv::status()" -e "renv::restore()" - "renv::status()"
