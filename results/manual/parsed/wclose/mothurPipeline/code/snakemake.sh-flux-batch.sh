#!/bin/bash
#FLUX: --job-name=clusterSnakemake
#FLUX: --queue=standard
#FLUX: -t=172800
#FLUX: --urgency=16

if [[ $SLURM_JOB_NODELIST ]] ; then
	echo "Running on"
	scontrol show hostnames $SLURM_JOB_NODELIST
	echo -e "\n"
fi
mkdir -p logs/slurm/
snakemake --use-conda --profile config/slurm/ --latency-wait 90
