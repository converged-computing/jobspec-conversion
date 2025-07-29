#!/bin/bash
#FLUX: --job-name=matlabjob
#FLUX: -n=16
#FLUX: --queue=rtx
#FLUX: -t=120
#FLUX: --urgency=16

module load matlab
matlab -nodesktop -nodisplay -nosplash < gputest.m
