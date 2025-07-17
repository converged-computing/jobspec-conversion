#!/bin/bash
#FLUX: --job-name=ml-matlab
#FLUX: --queue=alvis
#FLUX: -t=900
#FLUX: --urgency=16

ml purge
ml MATLAB
echo "Running MATLAB from $HOSTNAME"
matlab -batch regression
