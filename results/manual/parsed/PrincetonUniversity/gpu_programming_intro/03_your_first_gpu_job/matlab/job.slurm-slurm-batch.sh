#!/bin/bash
#FLUX: --job-name=matlab-svd
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load matlab/R2022a
matlab -singleCompThread -nodisplay -nosplash -r svd
