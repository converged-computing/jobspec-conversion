#!/bin/bash
#FLUX: --job-name=star-rsem
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --priority=16

set -e
cd $(pwd)
echo "Starting snakemake..."
snakemake --use-singularity -j 24
