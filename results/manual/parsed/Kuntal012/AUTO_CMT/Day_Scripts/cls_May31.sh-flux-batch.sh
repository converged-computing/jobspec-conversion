#!/bin/bash
#FLUX: --job-name=PF_May31 
#FLUX: -t=87300
#FLUX: --urgency=16

date
echo 'PF_May31;quit'|matlab -nodesktop
