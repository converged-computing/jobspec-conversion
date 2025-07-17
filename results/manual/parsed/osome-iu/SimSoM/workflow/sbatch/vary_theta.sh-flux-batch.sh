#!/bin/bash
#FLUX: --job-name=fzl5_theta
#FLUX: -c=57
#FLUX: -t=345540
#FLUX: --urgency=16

source /N/u/baotruon/BigRed200/conda/etc/profile.d/conda.sh
conda activate simsommodel
cd /N/u/baotruon/BigRed200/simsom
echo '###### running fzl5_theta exps ######'
snakemake --nolock --rerun-triggers mtime --rerun-incomplete --snakefile workflow/rules_zl5/vary_theta.smk --cores 57
