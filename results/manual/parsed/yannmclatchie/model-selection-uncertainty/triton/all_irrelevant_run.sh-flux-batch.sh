#!/bin/bash
#FLUX: --job-name=frigid-spoon-4796
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --priority=16

for current_dataset in {1..100}
do
    singularity run -B /scratch,/m,/l,/share /scratch/cs/bayes_ave/stan-triton.sif Rscript ./R/many-irrelevant/high_risk_experiment.R $1 $current_dataset $2
done
