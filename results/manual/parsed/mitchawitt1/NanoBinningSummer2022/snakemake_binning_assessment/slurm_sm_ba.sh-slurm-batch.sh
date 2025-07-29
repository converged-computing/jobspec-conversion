#!/bin/bash
#SBATCH --job-name=sm_CATBAT
#SBATCH --output=sm_catbat.out
#SBATCH --error=sm_catbat.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12G
#SBATCH --time=16:00:00
#SBATCH --partition=panda

source ~/.bashrc
cd /athena/ihlab/scratch/miw4007/simulation_test/tools/snakemake_binning_assessment/
snakemake --cores 4
exit
