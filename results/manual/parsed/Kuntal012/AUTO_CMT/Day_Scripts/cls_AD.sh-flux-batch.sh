#!/bin/bash
#FLUX: --job-name=PfCMT 
#FLUX: -t=173700
#FLUX: --urgency=16

date
echo 'PF_CMT;quit'|matlab -nodesktop
