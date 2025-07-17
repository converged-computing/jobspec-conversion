#!/bin/bash
#FLUX: --job-name=phigamma
#FLUX: -c=45
#FLUX: -t=345540
#FLUX: --urgency=16

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### vary phigamma ######'
snakemake --nolock --snakefile workflow/rules/phigamma.smk --cores 45
