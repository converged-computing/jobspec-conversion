#!/bin/bash
#FLUX: --job-name=PfCMT 
#FLUX: --queue=batch
#FLUX: -t=173700
#FLUX: --urgency=16

date
echo 'PF_CMT;quit'|matlab -nodesktop
