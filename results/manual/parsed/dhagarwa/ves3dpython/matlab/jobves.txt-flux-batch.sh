#!/bin/bash
#FLUX: --job-name=gpuvesjob
#FLUX: -n=16
#FLUX: --queue=rtx
#FLUX: -t=172800
#FLUX: --urgency=16

module load matlab
matlab -nodesktop -nodisplay -nosplash < testRun.m
