#!/bin/bash
#FLUX: --job-name=fzl5_thetagamma_cascade
#FLUX: -c=57
#FLUX: -t=345540
#FLUX: --urgency=16

source /N/u/baotruon/BigRed200/conda/etc/profile.d/conda.sh
conda activate simsommodel
cd /N/u/baotruon/BigRed200/simsom
echo '###### running fzl5_thetagamma exps ######'
snakemake --nolock --rerun-triggers mtime --snakefile workflow/rules_zl5/cascade/thetagamma.smk --cores 57
