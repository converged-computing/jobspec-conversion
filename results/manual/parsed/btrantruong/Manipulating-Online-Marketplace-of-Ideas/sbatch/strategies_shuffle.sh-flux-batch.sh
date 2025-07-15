#!/bin/bash
#FLUX: --job-name=shuffle
#FLUX: -c=48
#FLUX: -t=345540
#FLUX: --priority=16

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### compare strategies vary shuffle ######'
snakemake --nolock --snakefile workflow/rules/shuffle_network.smk --cores 48
