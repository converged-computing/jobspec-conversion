#!/bin/bash
#SBATCH --job-name=tools
#SBATCH --output=tools_%j.log
#SBATCH --mail-user=li002252@umn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
set -o nounset 
set -o errexit 
set -x 
python workflow/scripts/simulator.py
snakemake --cluster "sbatch  --partition=amd --nodes=1  --time=10:00:00 --mem=30gb --mail-user=li002252@umn.edu" -s workflow/Snakefile -j 2
