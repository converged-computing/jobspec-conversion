#!/bin/bash
#FLUX: --job-name=kvile_od
#FLUX: -N=10
#FLUX: -t=388800
#FLUX: --urgency=16

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module list  
echo 1+1
time /cluster/projects/nn8103k/NIVA-NOLA/opendrift_latest.sif python run_od_norkyst.py
exit 0
