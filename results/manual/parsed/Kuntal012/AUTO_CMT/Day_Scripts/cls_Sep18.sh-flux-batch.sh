#!/bin/bash
#FLUX: --job-name=PfSep18 
#FLUX: --queue=batch
#FLUX: -t=173700
#FLUX: --urgency=16

date
echo 'PF_Sep18;quit'|matlab -nodesktop
