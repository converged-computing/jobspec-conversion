#!/bin/bash
#FLUX: --job-name=<job-name>
#FLUX: -n=2
#FLUX: --queue=<partition-name>
#FLUX: -t=302400
#FLUX: --priority=16

source /path/to/baseenv/bin/activate upstream
snakemake --configfile=config/analysis.yaml all --cores 1 --unlock
snakemake --configfile=config/analysis.yaml all --cores 1 --rerun-incomplete
