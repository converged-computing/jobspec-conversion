#!/bin/bash
#FLUX: --job-name=everwatch_workflow_dryrun
#FLUX: -c=3
#FLUX: --queue=gpu
#FLUX: -t=5400
#FLUX: --priority=16

export TEST_ENV='True'

echo "INFO: [$(date "+%Y-%m-%d %H:%M:%S")] Starting everglades workflow on $(hostname) in $(pwd)"
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] Loading required modules"
source /etc/profile.d/modules.sh
ml conda
conda activate everwatch
export TEST_ENV=True
cd /blue/ewhite/everglades/everwatch-workflow/
snakemake --unlock
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] Starting Snakemake pipeline"
snakemake --printshellcmds --keep-going --cores 3 --resources gpu=1 --rerun-incomplete --latency-wait 1 --use-conda
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] End"
