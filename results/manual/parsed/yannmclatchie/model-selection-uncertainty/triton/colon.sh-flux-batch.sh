#!/bin/bash
#FLUX: --job-name=creamy-puppy-0078
#FLUX: -c=4
#FLUX: -t=432000
#FLUX: --urgency=16

module load r
module load gcc/11.2.0
srun Rscript ./R/real-world/colon.R $1 $2
