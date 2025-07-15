#!/bin/bash
#FLUX: --job-name=confused-lettuce-8849
#FLUX: -t=172800
#FLUX: --priority=16

CORES=32
PROJ= /hpcfs/users/a1680844/20131906_HickeyT_JC_NormalBreast
source activate Snakemake
cd /hpcfs/users/a1680844/20131906_HickeyT_JC_NormalBreast
snakemake \
  --cores ${CORES} \
  --use-conda \
  --notemp \
  --wrapper-prefix 'https://raw.githubusercontent.com/snakemake/snakemake-wrappers/'
bash /hpcfs/users/a1680844/20131906_HickeyT_JC_NormalBreast/scripts/update_git.sh
