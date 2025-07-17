#!/bin/bash
#FLUX: --job-name=PF_May22 
#FLUX: --queue=batch
#FLUX: -t=87300
#FLUX: --urgency=16

date
echo 'PF_May22;quit'|matlab -nodesktop
