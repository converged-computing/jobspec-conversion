#!/bin/bash
#FLUX: --job-name=sticky-poo-3027
#FLUX: --priority=16

date
source /etc/profile.d/modules.sh
module load  gcc/9.1.0
nwpesse input > job-nwps.log
date
