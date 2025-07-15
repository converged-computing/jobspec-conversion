#!/bin/bash
#FLUX: --job-name=gamma
#FLUX: -c=25
#FLUX: -t=345540
#FLUX: --priority=16

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### compare strategies vary gamma ######'
snakemake --nolock --snakefile workflow/rules/strategies_gamma.smk --cores 25
