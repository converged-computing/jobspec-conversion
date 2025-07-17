#!/bin/bash
#FLUX: --job-name=PfSep29 
#FLUX: --queue=batch
#FLUX: -t=173700
#FLUX: --urgency=16

date
echo 'PF_Sep29;quit'|matlab -nodesktop
