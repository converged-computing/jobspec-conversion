#!/bin/bash
#FLUX: --job-name=overarching
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.d/http_proxy.sh
if [[ $SLURM_JOB_NODELIST ]] ; then
    echo "Running on"
    scontrol show hostnames $SLURM_JOB_NODELIST
    echo -e "\n"
fi
snakemake --profile /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/CompetitiveMapping/Config --latency-wait 60 --use-conda --conda-prefix /home/hegartyb/miniconda3/envs/ --snakefile Snakefile-overarching --keep-going --rerun-incomplete
