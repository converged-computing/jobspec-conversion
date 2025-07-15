#!/bin/bash
#FLUX: --job-name=arid-cherry-7470
#FLUX: --urgency=16

module load Anaconda
source activate snakemake
./run_snakemake.sh live
