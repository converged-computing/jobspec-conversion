#!/bin/bash
#FLUX --job-name=bumfuzzled-spoon-9186
#FLUX -t=300
#FLUX --urgency=16

Rscript calc_freq.R file="data/sim$SLURM_ARRAY_TASK_ID.raw" outputDir="output/"
