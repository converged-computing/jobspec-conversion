#!/bin/bash
#FLUX: --job-name=eccentric-hippo-0930
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

singularity run -B /scratch,/m,/l,/share /scratch/cs/bayes_ave/stan-triton.sif Rscript ./R/forward-search/experiment.R $1 $2 $3 $4
