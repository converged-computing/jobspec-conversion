#!/bin/bash
#FLUX: --job-name=gloopy-plant-8945
#FLUX: -c=5
#FLUX: -t=600
#FLUX: --urgency=16

module load MATLAB/R2012b
srun matlab -nodesktop -nosplash -r myLu
