#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --urgency=16

source /etc/profile.d/http_proxy.sh 
if [[ $SLURM_JOB_NODELIST ]] ; then
	echo "Running on"
	scontrol show hostnames $SLURM_JOB_NODELIST
	echo -e "\n"
fi
snakemake --use-conda --verbose --profile config/slurm/  --latency-wait 90
