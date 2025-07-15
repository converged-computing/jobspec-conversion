#!/bin/bash
#FLUX: --job-name="parSampling"
#FLUX: -n=32
#FLUX: -t=36000
#FLUX: --priority=16

module load matlab
matlab -nodesktop -nosplash -r "parpool('local', 32); WSamplePar;"
echo "----"
hostname
