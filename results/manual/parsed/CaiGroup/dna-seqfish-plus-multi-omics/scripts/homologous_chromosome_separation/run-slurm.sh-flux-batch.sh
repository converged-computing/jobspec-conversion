#!/bin/bash
#FLUX: --job-name=lovable-platanos-2844
#FLUX: -t=86400
#FLUX: --urgency=16

module load julia/1.6.2
snakemake --cores=1 --cluster 'sbatch -t 2000 --mem=5g -c 1' -j 100 
