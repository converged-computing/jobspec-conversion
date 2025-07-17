#!/bin/bash
#FLUX: --job-name=PfSep12 
#FLUX: --queue=batch
#FLUX: -t=173700
#FLUX: --urgency=16

date
echo 'PF_Sep12;quit'|matlab -nodesktop
