#!/bin/bash
#FLUX: --job-name=clusterSnakemake
#FLUX: --queue=standard
#FLUX: -t=2700
#FLUX: --urgency=16

if [[ $SLURM_JOB_NODELIST ]] ; then
	echo "Running on"
	scontrol show hostnames $SLURM_JOB_NODELIST
	echo -e "\n"
fi
snakemake --profile config/slurm/ --latency-wait 20
