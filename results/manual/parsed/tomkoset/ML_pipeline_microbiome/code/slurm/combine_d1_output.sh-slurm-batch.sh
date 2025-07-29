#!/bin/bash
#SBATCH --job-name=combine-d1-output
#SBATCH --account=pschloss1
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=tomkoset@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=1

mkdir -p logs/slurm/
bash code/bash/d1_cat_csv_files.sh
