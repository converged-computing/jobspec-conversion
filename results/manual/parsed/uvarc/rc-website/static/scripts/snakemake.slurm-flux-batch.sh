#!/bin/bash
#FLUX: --job-name=milky-motorcycle-0412
#FLUX: --priority=16

module purge
module load anaconda
source activate rnaseq
snakemake -p -j 8
