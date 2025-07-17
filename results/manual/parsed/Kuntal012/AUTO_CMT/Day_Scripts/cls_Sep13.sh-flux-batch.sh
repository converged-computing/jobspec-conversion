#!/bin/bash
#FLUX: --job-name=PfSep13 
#FLUX: --queue=batch
#FLUX: -t=173700
#FLUX: --urgency=16

date
echo 'PF_Sep13;quit'|matlab -nodesktop
