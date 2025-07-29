#!/bin/bash
#FLUX: --job-name=downsample
#FLUX: --queue=standard
#FLUX: -t=7200
#FLUX: --urgency=16

source /etc/profile.d/http_proxy.sh
if [[ $SLURM_JOB_NODELIST ]] ; then
    echo "Running on"
    scontrol show hostnames $SLURM_JOB_NODELIST
    echo -e "\n"
fi
DIR='/home/klangenf/anaconda/envs' ### Update to user specific anaconda environment locations
snakemake --profile Config --latency-wait 300 --use-conda --conda-prefix $DIR --conda-frontend mamba --snakefile Snakefile-downsample
