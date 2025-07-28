#!/bin/bash
#FLUX: --job-name=chunky-noodle-4774
#FLUX: -t=300
#FLUX: --urgency=16

Rscript calc_freq.R file="data/sim$SLURM_ARRAY_TASK_ID.raw" outputDir="output/"
