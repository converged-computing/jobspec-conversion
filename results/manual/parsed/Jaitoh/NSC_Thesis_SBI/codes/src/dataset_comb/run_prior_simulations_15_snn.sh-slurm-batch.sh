#!/bin/bash
#SBATCH --job-name=gen_dataset_comb_15
#SBATCH --output=./cluster/uzh/prior_sim/gen_dataset_comb_15_%a.out
#SBATCH --error=./cluster/uzh/prior_sim/gen_dataset_comb_15_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G
#SBATCH --time=1-00:00:00
#SBATCH --array=0-19

alphas=({0..95..5})
gammas=({5..100..5})
for i in ${!alphas[@]}; do
    alpha=${alphas[$i]}
    gamma=${gammas[$i]}
    alphaArr+=($alpha)
    gammaArr+=($gamma)
    python3 -u ./src/analysis/prior_range.py --dur_list [15] --task_part [${alpha},${gamma}] &
done
