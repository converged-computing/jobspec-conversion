#!/bin/bash
#FLUX: --job-name=persnickety-lemon-2218
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

module load r
module load gcc/11.2.0
srun Rscript ./R/real-world/ionosphere.R $1 $2
