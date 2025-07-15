#!/bin/bash
#FLUX: --job-name="CATCHUP-vpipe"
#FLUX: -t=82800
#FLUX: --priority=16

export SNAKEMAKE_PROFILE='$(realpath ../profiles/)'

umask 0007
./vpipe --dryrun --unlock
echo "Using proxy"
. /etc/profile.d/software_stack_default.sh
module load eth_proxy
echo "${https_proxy}"
mkdir -p cluster_logs/
export SNAKEMAKE_PROFILE=$(realpath ../profiles/)
exec ./vpipe --profile ${SNAKEMAKE_PROFILE}/smk-simple-slurm/ --until dehuman prepare_upload
