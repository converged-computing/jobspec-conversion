#!/bin/bash
#SBATCH --job-name=L2_logit-d1_family
#SBATCH --account=pschloss1
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=tomkoset@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-100

seed=$(($SLURM_ARRAY_TASK_ID - 1))
mkdir -p logs/slurm/
Rscript code/R/main.R --seed $seed --model L2_Logistic_Regression --data  test/data/classification_input_day1_data_family.csv --hyperparams test/data/hyperparams.csv --outcome dx
