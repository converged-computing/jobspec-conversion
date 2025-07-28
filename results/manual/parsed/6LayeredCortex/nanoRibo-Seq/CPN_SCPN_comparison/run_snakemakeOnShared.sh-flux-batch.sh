#!/bin/bash
#FLUX: --job-name=sticky-parrot-4547
#FLUX: --queue=shared
#FLUX: -t=86400
#FLUX: --urgency=16

module load Anaconda
source activate snakemake
./run_snakemake.sh live
