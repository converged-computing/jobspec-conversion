#!/bin/bash
#FLUX --job-name=reclusive-banana-2853
#FLUX -t=1800
#FLUX --urgency=16

module load matlab
srun matlab -nodisplay -r serial
