#!/bin/bash
#FLUX: --job-name=assemblies
#FLUX: --queue=standard
#FLUX: -t=432000
#FLUX: --priority=16

source /etc/profile.d/http_proxy.sh
if [[ $SLURM_JOB_NODELIST ]] ; then
    echo "Running on"
    scontrol show hostnames $SLURM_JOB_NODELIST
    echo -e "\n"
fi
snakemake --profile /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/Config --latency-wait 20 --use-conda --conda-prefix /home/hegartyb/miniconda3/envs/ --snakefile Snakefile_virsorter
