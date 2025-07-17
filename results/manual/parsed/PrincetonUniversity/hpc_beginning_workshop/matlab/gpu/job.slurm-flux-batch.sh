#!/bin/bash
#FLUX: --job-name=matlab-svd
#FLUX: -t=120
#FLUX: --urgency=16

module purge
module load matlab/R2021b
matlab -singleCompThread -nodisplay -nosplash -r svd
