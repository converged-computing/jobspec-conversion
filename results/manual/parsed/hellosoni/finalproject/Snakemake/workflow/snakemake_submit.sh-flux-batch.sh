#!/bin/bash
#FLUX: --job-name=scruptious-kitty-6224
#FLUX: -n=6
#FLUX: -t=36000
#FLUX: --priority=16

set -e -u -o pipefail
module load python/3.6-conda5.2
source activate ipy-env
snakemake -j"$SLURM_NTASKS" -p  
