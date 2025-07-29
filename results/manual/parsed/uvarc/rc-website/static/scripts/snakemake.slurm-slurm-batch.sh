#!/bin/bash
#FLUX: --job-name=buttery-lemon-0761
#FLUX: -n=9
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load anaconda
source activate rnaseq
snakemake -p -j 8
