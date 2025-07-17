#!/bin/bash
#FLUX: --job-name=Serial_Job
#FLUX: -c=5
#FLUX: -t=600
#FLUX: --urgency=16

module load MATLAB/R2012b
srun matlab -nodesktop -nosplash -r myLu
