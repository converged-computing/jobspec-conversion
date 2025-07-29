#!/bin/bash
#FLUX: --job-name=anxious-pedo-7009
#FLUX: -t=1800
#FLUX: --urgency=16

module load matlab
srun matlab -nodisplay -r serial
