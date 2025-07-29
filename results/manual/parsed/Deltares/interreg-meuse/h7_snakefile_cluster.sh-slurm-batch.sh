#!/bin/bash
#SBATCH --job-name=daily_interreg
#SBATCH --output=daily_run_%j.log
#SBATCH --mail-user=anais.couasnon@deltares.nl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=1vcpu

source /u/couasnon/miniconda3/bin/activate hydromt-wflow
conda config --set channel_priority strict
ROOT="/u/couasnon/git_repos/interreg-meuse"
cd "${ROOT}"
snakemake --unlock -s snakefile --configfile config/members_config.yml 
snakemake -s snakefile --configfile config/members_config.yml --profile interreg_daily/ --wait-for-files --directory $PWD  --rerun-triggers mtime #--group-components preprocess=3120 xr_merge=50  #--retries 2 --allowed-rules run_wflow
conda deactivate
