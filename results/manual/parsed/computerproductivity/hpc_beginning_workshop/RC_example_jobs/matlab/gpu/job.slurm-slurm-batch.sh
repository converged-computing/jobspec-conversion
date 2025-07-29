#!/bin/bash
#FLUX: --job-name=matlab-svd
#FLUX: -t=120
#FLUX: --urgency=16

module purge
module load matlab/R2019a
matlab -singleCompThread -nodisplay -nosplash -r svd
