#!/bin/bash
#SBATCH --job-name=combine-d0-output
#SBATCH --account=pschloss1
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=tomkoset@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=250m
#SBATCH --time=05:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

mkdir -p logs/slurm/
bash code/bash/family_d0_cat_csv_files.sh
