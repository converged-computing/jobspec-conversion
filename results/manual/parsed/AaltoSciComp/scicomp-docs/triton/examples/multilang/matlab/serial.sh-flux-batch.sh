#!/bin/bash
#FLUX --job-name=ornery-house-6919
#FLUX -t=1800
#FLUX --urgency=16

module load matlab
srun matlab -nodisplay -r serial
