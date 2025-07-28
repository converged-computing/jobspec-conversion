#!/bin/bash
#FLUX: --job-name=daily_interreg
#FLUX: --queue=1vcpu
#FLUX: -t=86400
#FLUX: --urgency=16

source /u/couasnon/miniconda3/bin/activate hydromt-wflow
conda config --set channel_priority strict
ROOT="/u/couasnon/git_repos/interreg-meuse"
cd "${ROOT}"
snakemake --unlock -s snakefile --configfile config/members_config.yml 
snakemake -s snakefile --configfile config/members_config.yml --profile interreg_daily/ --wait-for-files --directory $PWD  --rerun-triggers mtime #--group-components preprocess=3120 xr_merge=50  #--retries 2 --allowed-rules run_wflow
conda deactivate
