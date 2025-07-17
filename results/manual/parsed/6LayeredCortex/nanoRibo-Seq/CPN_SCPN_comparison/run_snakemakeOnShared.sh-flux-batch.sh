#!/bin/bash
#FLUX: --job-name=expensive-pedo-9893
#FLUX: --queue=shared
#FLUX: -t=86400
#FLUX: --urgency=16

module load Anaconda
source activate snakemake
./run_snakemake.sh live
