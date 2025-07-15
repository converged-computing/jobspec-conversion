#!/bin/bash
#FLUX: --job-name=strawberry-pedo-1889
#FLUX: --priority=16

module load Anaconda
source activate snakemake
./run_snakemake.sh live
