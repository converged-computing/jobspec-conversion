#!/bin/bash
#FLUX: --job-name=matlab
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load matlab/R2019a
matlab -singleCompThread -nodisplay -nosplash -nojvm -r hello_world
