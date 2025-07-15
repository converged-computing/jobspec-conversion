#!/bin/bash
#FLUX: --job-name=everglades_workflow
#FLUX: -c=60
#FLUX: --queue=gpu
#FLUX: -t=288000
#FLUX: --urgency=16

echo "INFO: [$(date "+%Y-%m-%d %H:%M:%S")] Starting everglades workflow on $(hostname) in $(pwd)"
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] Loading required modules"
source /etc/profile.d/modules.sh
ml conda
conda activate everwatch
cd /blue/ewhite/everglades/everwatch-workflow/
snakemake --unlock
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] Starting Snakemake pipeline"
snakemake --printshellcmds --keep-going --cores 60 --resources gpu=4 --rerun-incomplete --latency-wait 10 --use-conda
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] End"
