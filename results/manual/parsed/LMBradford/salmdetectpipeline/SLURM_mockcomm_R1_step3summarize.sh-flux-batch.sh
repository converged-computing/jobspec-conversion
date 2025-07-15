#!/bin/bash
#FLUX: --job-name=lovely-peanut-butter-3486
#FLUX: -t=600
#FLUX: --priority=16

export R_LIBS='~/.local/R/$EBVERSIONR/'

module load StdEnv/2020   # This is already loaded, but for future compatibility...
module load gcc/9.3.0
module load python/3.9
module load scipy-stack
export R_LIBS=~/.local/R/$EBVERSIONR/
source ~/env/bin/activate
snakemake -s snakefile_mockcomm_step3summarize.py --configfile configs/mockcomm_Round1.yaml --cores 1
