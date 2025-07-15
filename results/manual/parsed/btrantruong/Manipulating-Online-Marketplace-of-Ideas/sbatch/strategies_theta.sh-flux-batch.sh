#!/bin/bash
#FLUX: --job-name=strategy_theta
#FLUX: -c=20
#FLUX: -t=345540
#FLUX: --priority=16

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### compare strategies vary theta ######'
snakemake --snakefile workflow/rules/strategies_theta.smk --cores 20
