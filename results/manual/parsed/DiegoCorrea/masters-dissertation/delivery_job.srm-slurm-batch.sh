#!/bin/bash
#SBATCH --job-name=Rec_test
#SBATCH --output=logs/slurm/slurm-%A.out
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=60GB
#SBATCH --partition=nvidia_dev
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

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
