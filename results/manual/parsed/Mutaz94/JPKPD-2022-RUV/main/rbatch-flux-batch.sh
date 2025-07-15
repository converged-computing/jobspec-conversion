#!/bin/bash
#FLUX: --job-name=angry-pot-4272
#FLUX: -n=20
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.d/modules.sh 
module load impi 
module load R/4.1.0 
conda activate ruv
make all 
