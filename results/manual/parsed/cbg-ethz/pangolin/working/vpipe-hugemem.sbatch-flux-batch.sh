#!/bin/bash
#FLUX: --job-name="COVID-vpipe-hugemem"
#FLUX: -t=345600
#FLUX: --priority=16

export SNAKEMAKE_PROFILE='$(realpath ../profiles/)'

umask 0007
sleep 300
./vpipe --configfile config.unlock.yaml ---dryrun --unlock
mkdir -p cluster_logs/
export SNAKEMAKE_PROFILE=$(realpath ../profiles/)
exec ./vpipe --profile ${SNAKEMAKE_PROFILE}/custom-lsf/ --configfile config.hugemem.yaml
