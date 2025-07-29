#!/bin/bash
#SBATCH --job-name=TestCalib
#SBATCH --mail-user=alyssa_bilinski@brown.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:03:00
#SBATCH --partition=batch

module load gcc/10.2 pcre2/10.35 intel/2020.2 texlive/2018 R/3.5.2
R CMD BATCH --quiet --no-restore --no-save delete_files.R test_delete.out
