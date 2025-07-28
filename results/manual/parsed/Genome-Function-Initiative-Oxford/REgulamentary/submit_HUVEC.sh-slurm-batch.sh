#!/bin/bash
#FLUX: --job-name=HUVEC
#FLUX: -n=2
#FLUX: --queue=<partition-name>
#FLUX: -t=302400
#FLUX: --urgency=16

source /path/to/baseenv/bin/activate re
snakemake --configfile=config/endothelial-cell-of-umbilical-vein.yaml all --cores 2 --unlock
snakemake --configfile=config/endothelial-cell-of-umbilical-vein.yaml all --cores 2 --rerun-incomplete
