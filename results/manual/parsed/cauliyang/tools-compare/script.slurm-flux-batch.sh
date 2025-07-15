#!/bin/bash
#FLUX: --job-name=tools
#FLUX: -t=72000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
set -o nounset 
set -o errexit 
set -x 
python workflow/scripts/simulator.py
snakemake --cluster "sbatch  --partition=amd --nodes=1  --time=10:00:00 --mem=30gb --mail-user=li002252@umn.edu" -s workflow/Snakefile -j 2
