#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: -n=20
#FLUX: --queue=bmh
#FLUX: -t=115200
#FLUX: --urgency=16

set -e                                                                     # Error if a single command fails
set -x                                                                     # Error if un-named variables calledset -x  >set -x
set -u
module load conda/latest
conda activate snakebio3
snakemake -j 20
