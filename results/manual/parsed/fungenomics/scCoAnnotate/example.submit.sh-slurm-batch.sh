#!/bin/bash
#SBATCH --job-name=scCoAnnotate
#SBATCH --account=rrg-kleinman
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=60GB
#SBATCH --time=1-00:00:00

module load scCoAnnotate/2.0
snakefile=<path to snakefile>
config=<path to configfile>
snakemake -s ${snakefile} --configfile ${config} --unlock 
snakemake -s ${snakefile} --configfile ${config} --cores 5
