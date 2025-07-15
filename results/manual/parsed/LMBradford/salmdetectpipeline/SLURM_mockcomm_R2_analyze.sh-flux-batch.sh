#!/bin/bash
#FLUX: --job-name=hanky-plant-8192
#FLUX: -c=4
#FLUX: -t=9600
#FLUX: --urgency=16

export R_LIBS='~/.local/R/$EBVERSIONR/'

module load StdEnv/2020   # This is already loaded, but for future compatibility...
module load gcc/9.3.0
module load kraken2/2.1.1
module load bbmap/38.86
module load trimmomatic/0.39
module load blast+/2.12.0
module load diamond/2.0.13
module load python/3.9
export R_LIBS=~/.local/R/$EBVERSIONR/
source ~/env/bin/activate
snakemake -s snakefile_mockcomm_R2_step2analyze.py --configfile configs/mockcomm_Round2.yaml --cores all
