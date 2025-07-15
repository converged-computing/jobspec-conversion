#!/bin/bash
#FLUX: --job-name=nerdy-nalgas-4727
#FLUX: -t=1800
#FLUX: --priority=16

module load matlab
srun matlab -nodisplay -r serial
