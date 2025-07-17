#!/bin/bash
#FLUX: --job-name=delicious-poodle-8749
#FLUX: -t=1800
#FLUX: --urgency=16

module load matlab
srun matlab -nodisplay -r serial
