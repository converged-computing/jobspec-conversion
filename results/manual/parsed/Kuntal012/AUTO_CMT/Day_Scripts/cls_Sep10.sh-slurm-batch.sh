#!/bin/bash
#FLUX: --job-name=PfSep10 
#FLUX: --queue=batch
#FLUX: -t=173700
#FLUX: --urgency=16

date
echo 'PF_Sep10;quit'|matlab -nodesktop
