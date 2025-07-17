#!/bin/bash
#FLUX: --job-name=PF_April7 
#FLUX: --queue=batch
#FLUX: -t=87300
#FLUX: --urgency=16

date
echo 'PF_April7;quit'|matlab -nodesktop
