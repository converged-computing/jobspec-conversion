#!/bin/bash
#SBATCH --get-user-env
#SBATCH --job-name="emnlp_baseline"
#SBATCH --time=05:59:00
#SBATCH --nodes=1
#SBATCH --mem=200GB
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --qos=express

echo "loading"
module load python/3.6.1
module load cudnn/v6
module load cuda/8.0.61
module load tensorflow/1.5.0-py36-gpu
echo "loaded"
#rm /datastore/liu121/nosqldb2/multiclass/report_bbn_kn/*
python learn.py --num $1