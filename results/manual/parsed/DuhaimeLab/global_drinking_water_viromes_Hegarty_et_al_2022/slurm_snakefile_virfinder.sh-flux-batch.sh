#!/bin/bash
#FLUX: --job-name=virfinder
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --priority=16

source /etc/profile.d/http_proxy.sh
if [[ $SLURM_JOB_NODELIST ]] ; then
    echo "Running on"
    scontrol show hostnames $SLURM_JOB_NODELIST
    echo -e "\n"
fi
snakemake --profile /nfs/turbo/cee-kwigg/hegartyb/SnakemakeAssemblies3000/Config --latency-wait 60 --use-conda --conda-prefix /home/hegartyb/miniconda3/envs/ --snakefile Snakefile_virfinder
