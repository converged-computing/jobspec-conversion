#!/bin/bash
#FLUX: --job-name=marketplacesnakemake
#FLUX: -c=20
#FLUX: -t=345540
#FLUX: --urgency=16

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### compare strategies vary thetaphi ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/compare_strategies.smk --cores 20
echo '###### vary theta phi ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/vary_thetaphi.smk --cores 20
echo '###### vary theta gamma ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/vary_thetagamma.smk --cores 20
echo '###### vary phi gamma ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/vary_phigamma.smk --cores 20
echo '###### vary beta gamma ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/vary_betagamma.smk --cores 20
