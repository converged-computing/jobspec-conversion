#!/bin/bash
#FLUX: --job-name=gloopy-lamp-7228
#FLUX: --priority=16

ml purge
ml MATLAB
echo "Running MATLAB from $HOSTNAME"
matlab -batch regression
