#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=184GB
#SBATCH --time=00:12:00
#SBATCH --partition=fasse

date #print start time
snakemake --cores 6
date #print end time
