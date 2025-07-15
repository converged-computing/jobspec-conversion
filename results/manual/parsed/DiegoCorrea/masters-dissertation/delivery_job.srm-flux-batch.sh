#!/bin/bash
#FLUX: --job-name=stinky-lemon-2848
#FLUX: -N=3
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --urgency=16

echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST
cd /scratch/calibrec/diego.silva/calibrated_recommendation/
recommenders=(SVD)
folds=(1 2 3)
dataset="Movielens-25M"
for i in "${recommenders[@]}";
do
    for j in 1 2 3;
    do
        echo "Recommender Job: $i"
        echo "Fold: $j"
        srun  -N 1 -n 1  /scratch/calibrec/diego.silva/.conda/envs/calibrated_recommendation/bin/python3.7 recommenders.py --recommender="$i" --fold=$j --dataset="$dataset" &
    done
done
wait
