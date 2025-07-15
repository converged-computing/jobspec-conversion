#!/bin/bash
#FLUX: --job-name=mu_fzl5
#FLUX: -c=43
#FLUX: -t=345540
#FLUX: --priority=16

source /N/u/baotruon/BigRed200/conda/etc/profile.d/conda.sh
conda activate simsommodel
cd /N/u/baotruon/BigRed200/simsom
echo '###### running mu_fzl5 exps ######'
snakemake --nolock --rerun-triggers mtime --rerun-incomplete --snakefile workflow/rules_zl5/vary_mu.smk --cores 43
