#!/bin/bash
#FLUX: --job-name=fzl5_phigamma_mphi10
#FLUX: -c=57
#FLUX: -t=345540
#FLUX: --urgency=16

source /N/u/baotruon/BigRed200/conda/etc/profile.d/conda.sh
conda activate simsommodel
cd /N/u/baotruon/BigRed200/simsom
echo '###### running fzl5_phigamma_mphi10 exps ######'
snakemake --nolock --rerun-triggers mtime --rerun-incomplete --snakefile workflow/rules_zl5/phigamma_maxphi10.smk --cores 57
