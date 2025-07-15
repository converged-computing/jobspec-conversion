#!/bin/bash
#FLUX: --job-name=pusheena-caramel-5283
#FLUX: -c=4
#FLUX: -t=21600
#FLUX: --urgency=16

for current_dataset in {1..50}
do
    singularity run -B /scratch,/m,/l,/share /scratch/cs/bayes_ave/stan-triton.sif Rscript ./R/many-irrelevant/fit_many_models.R $1 $current_dataset $2
    # srun Rscript ./R/many-irrelevant/fit_many_models.R $1 $current_dataset $2
done
