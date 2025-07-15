#!/bin/bash
#FLUX: --job-name=crunchy-bits-9732
#FLUX: --priority=16

module load java/sun_jdk1.8.0_151
source activate v3
snakemake --unlock -s ./tiger.snek --configfile config/config_rackham_all_samples.yaml  --rerun-incomplete 
snakemake --keep-going -j 13 -s ./tiger.snek  --configfile config/config_rackham_all_samples.yaml  --rerun-incomplete --use-conda
