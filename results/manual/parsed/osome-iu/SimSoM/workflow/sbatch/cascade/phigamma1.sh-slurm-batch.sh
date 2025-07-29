#!/bin/bash
#FLUX: --job-name=fzl5_phigamma_mphi10_cascade
#FLUX: -c=57
#FLUX: -t=345540
#FLUX: --urgency=16

source /N/u/baotruon/BigRed200/conda/etc/profile.d/conda.sh
conda activate simsommodel
cd /N/u/baotruon/BigRed200/simsom
echo '###### running fzl5_phigamma_mphi10_cascade exps ######'
snakemake --rerun-incomplete --nolock --rerun-triggers mtime --snakefile workflow/rules_zl5/cascade/phigamma1.smk --cores 57
