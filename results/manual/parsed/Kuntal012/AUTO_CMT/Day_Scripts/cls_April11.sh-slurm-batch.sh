#!/bin/bash
#FLUX: --job-name=PF_April11 
#FLUX: --queue=batch
#FLUX: -t=87300
#FLUX: --urgency=16

date
echo 'PF_April11;quit'|matlab -nodesktop
