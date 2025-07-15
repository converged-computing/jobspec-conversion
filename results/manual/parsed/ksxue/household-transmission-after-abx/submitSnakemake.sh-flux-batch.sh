#!/bin/bash
#FLUX: --job-name=submitSnakemake
#FLUX: -c=16
#FLUX: -t=345600
#FLUX: --priority=16

source activate snakemake
snakemake --use-conda --cores 24 --cluster 'sbatch -t 96:00:00 --mem=96g -c 24 -p relman' -j 25 --max-jobs-per-second 3 --max-status-checks-per-second 3
