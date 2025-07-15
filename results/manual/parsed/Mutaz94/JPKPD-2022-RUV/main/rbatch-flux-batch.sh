#!/bin/bash
#FLUX: --job-name=psycho-poodle-2459
#FLUX: -n=20
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.d/modules.sh 
module load impi 
module load R/4.1.0 
conda activate ruv
make all 
