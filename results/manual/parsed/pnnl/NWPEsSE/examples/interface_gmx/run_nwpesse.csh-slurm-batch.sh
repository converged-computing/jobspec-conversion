#!/bin/bash
#FLUX: --job-name=nwps
#FLUX: -t=14379
#FLUX: --urgency=16

date
source /etc/profile.d/modules.sh
module load  gcc/9.1.0
nwpesse input > job-nwps.log
date
