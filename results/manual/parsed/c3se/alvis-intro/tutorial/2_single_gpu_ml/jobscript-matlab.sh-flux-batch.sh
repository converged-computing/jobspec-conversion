#!/bin/bash
#FLUX: --job-name=confused-mango-8303
#FLUX: --urgency=16

ml purge
ml MATLAB
echo "Running MATLAB from $HOSTNAME"
matlab -batch regression
