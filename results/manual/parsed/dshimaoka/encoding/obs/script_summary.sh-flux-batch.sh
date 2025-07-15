#!/bin/bash
#FLUX: --job-name=Summary
#FLUX: -c=9
#FLUX: --queue=m3g
#FLUX: -t=86400
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nodesktop -nosplash < summaryAcrossPix.m
