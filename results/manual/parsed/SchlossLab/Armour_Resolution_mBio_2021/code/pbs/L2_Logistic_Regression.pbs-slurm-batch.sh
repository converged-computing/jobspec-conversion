#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --account=pschloss1
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=begumtop@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=01:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-100

seed=$(($SLURM_ARRAY_TASK_ID - 1))
mkdir -p logs/slurm/
Rscript code/learning/main.R $seed "L2_Logistic_Regression"
