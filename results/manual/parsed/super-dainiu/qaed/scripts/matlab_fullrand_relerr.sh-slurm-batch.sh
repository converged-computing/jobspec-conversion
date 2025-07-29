#!/bin/bash
#FLUX: --job-name=fullrand_cpu
#FLUX: -c=5
#FLUX: --queue=day
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load MATLAB/2023a
matlab -nodisplay -nosplash -nodesktop -r "run('/home/ys792/project/qaed/test_relerr_fullrand.m');exit;"
