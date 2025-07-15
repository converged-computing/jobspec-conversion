#!/bin/bash
#FLUX: --job-name=delicious-leader-9933
#FLUX: -t=3600
#FLUX: --urgency=16

export R_LIBS='~/.local/R/$EBVERSIONR/'

module load StdEnv/2020   # This is already loaded, but for future compatibility...
module load gcc/9.3.0
module load bbmap/38.86
module load python/3.9
export R_LIBS=~/.local/R/$EBVERSIONR/
source ~/env/bin/activate
snakemake -s snakefile_ccmockcomm_step1setup.py -p --cores --configfile configs/mockcomm_step1_setup.yaml
