#!/bin/bash
#FLUX: --job-name=gen_dataset_comb_15
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

alphas=({0..95..5})
gammas=({5..100..5})
for i in ${!alphas[@]}; do
    alpha=${alphas[$i]}
    gamma=${gammas[$i]}
    alphaArr+=($alpha)
    gammaArr+=($gamma)
    python3 -u ./src/analysis/prior_range.py --dur_list [15] --task_part [${alpha},${gamma}] &
done
