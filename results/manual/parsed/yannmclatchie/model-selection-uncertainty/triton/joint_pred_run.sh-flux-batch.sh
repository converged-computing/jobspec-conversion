#!/bin/bash
#FLUX: --job-name=misunderstood-pastry-5933
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --urgency=16

for current_dataset in {1..10}
do
    singularity run -B /scratch,/m,/l,/share docker://andrjohns/stan-triton Rscript ./R/joint-predictive/joint-predictive-sample-beta.R $1 $current_dataset $2 $3
done
