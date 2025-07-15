#!/bin/bash
#FLUX: --job-name=placid-chip-5680
#FLUX: --urgency=16

date
source /etc/profile.d/modules.sh
module load  gcc/9.1.0
nwpesse input > job-nwps.log
date
