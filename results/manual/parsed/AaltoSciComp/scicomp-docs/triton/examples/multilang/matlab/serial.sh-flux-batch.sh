#!/bin/bash
#FLUX: --job-name=butterscotch-soup-2193
#FLUX: -t=1800
#FLUX: --urgency=16

module load matlab
srun matlab -nodisplay -r serial
