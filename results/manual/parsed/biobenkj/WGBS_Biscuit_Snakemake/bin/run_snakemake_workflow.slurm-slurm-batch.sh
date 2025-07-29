#!/bin/bash
#SBATCH --job-name=SNAKEMASTER
#SBATCH --output=logs/workflows/workflow_output-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=4-00:00:00

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
