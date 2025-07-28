#!/bin/bash
#FLUX: --job-name=gloopy-house-1796
#FLUX: -t=1800
#FLUX: --urgency=16

module load matlab
srun matlab -nodisplay -r serial
