#!/bin/bash
#FLUX --job-name=carnivorous-general-9293
#FLUX -c=4
#FLUX -t=172800
#FLUX --urgency=16

module load r
module load gcc/11.2.0
srun Rscript ./R/real-world/heart.R $1 $2
