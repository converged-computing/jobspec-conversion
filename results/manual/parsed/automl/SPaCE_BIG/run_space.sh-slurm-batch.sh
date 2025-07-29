#!/bin/bash
#SBATCH --job-name=space_cpm
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10000M
#SBATCH --time=08:00:00

python src/space_ray.py  --mode spl --test features/cpm_test.csv --instances features/cpm_train.csv
