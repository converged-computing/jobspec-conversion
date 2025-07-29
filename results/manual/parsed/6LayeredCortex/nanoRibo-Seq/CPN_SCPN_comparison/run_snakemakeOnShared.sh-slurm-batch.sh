#!/bin/bash
#FLUX: --job-name=gloopy-milkshake-1862
#FLUX: --queue=shared
#FLUX: -t=86400
#FLUX: --urgency=16

module load Anaconda
source activate snakemake
./run_snakemake.sh live
