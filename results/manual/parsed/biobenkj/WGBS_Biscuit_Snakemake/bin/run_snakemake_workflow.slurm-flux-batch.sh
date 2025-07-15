#!/bin/bash
#FLUX: --job-name=SNAKEMASTER
#FLUX: --priority=16

cd ${SLURM_SUBMIT_DIR}
mkdir -p logs/workflows
TIME=$(date "+%Y-%m-%d_%H.%M.%S")
snakemake --configfile config/config.yaml --profile profile/ --dry-run         > logs/workflows/workflow_${TIME}.txt
snakemake --configfile config/config.yaml --profile profile/ --dag | dot -Tpng > logs/workflows/workflow_${TIME}.png
snakemake \
    --configfile config/config.yaml \
    --profile profile/ \
    --slurm \
    --default-resources slurm_account=[ENTER YOUR SLURM ACCOUNT] slurm_partition=[ENTER SLURM PARTITION TO USE]
