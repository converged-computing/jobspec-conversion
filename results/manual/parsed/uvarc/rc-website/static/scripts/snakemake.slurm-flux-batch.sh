#!/bin/bash
#FLUX: --job-name=cowy-butter-2588
#FLUX: --urgency=16

module purge
module load anaconda
source activate rnaseq
snakemake -p -j 8
