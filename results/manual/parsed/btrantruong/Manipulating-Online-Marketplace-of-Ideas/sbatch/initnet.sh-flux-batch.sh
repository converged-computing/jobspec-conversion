#!/bin/bash
#FLUX: --job-name=initnet
#FLUX: -c=23
#FLUX: -t=345540
#FLUX: --urgency=16

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### init net ######'
snakemake --nolock --snakefile workflow/rules/initnet.smk --cores 23
