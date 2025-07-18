#!/bin/bash
#FLUX: --job-name=tiger_snek
#FLUX: -n=15
#FLUX: --queue=core
#FLUX: -t=36000
#FLUX: --urgency=16

module load java/sun_jdk1.8.0_151
source activate v3
snakemake --unlock -s ./tiger.snek --configfile config/config_rackham_all_samples.yaml  --rerun-incomplete 
snakemake --keep-going -j 13 -s ./tiger.snek  --configfile config/config_rackham_all_samples.yaml  --rerun-incomplete --use-conda
