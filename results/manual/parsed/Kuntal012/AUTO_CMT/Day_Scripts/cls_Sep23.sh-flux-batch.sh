#!/bin/bash
#FLUX: --job-name=PfSep23 
#FLUX: --queue=batch
#FLUX: -t=173700
#FLUX: --urgency=16

date
echo 'PF_Sep23;quit'|matlab -nodesktop
