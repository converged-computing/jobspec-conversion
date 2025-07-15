#!/bin/bash
#FLUX: --job-name=my-matlab
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load matlab
module list
srun matlab -singleCompThread -nodisplay -nosplash -nojvm -r hello_world
