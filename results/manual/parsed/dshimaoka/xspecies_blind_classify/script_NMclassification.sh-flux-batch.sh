#!/bin/bash
#FLUX: --job-name=Wrapper
#FLUX: -t=7200
#FLUX: --priority=16

module load matlab/r2021a
matlab -nodisplay -nodesktop -nosplash < awake_unconscious_NMclassification_channels.m
