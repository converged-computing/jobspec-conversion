#!/bin/bash
#FLUX: --job-name=snakemake_scvi
#FLUX: -t=7200
#FLUX: --priority=16

export SBATCH_DEFAULTS=' --output=/fast/users/twei_m/scratch/snakemake_scvi_%j.log'

export SBATCH_DEFAULTS=" --output=/fast/users/twei_m/scratch/snakemake_scvi_%j.log"
source activate /fast/users/twei_m/work/miniconda/envs/scvi
date
srun snakemake --cluster "sbatch -t 2:00:00 -p gpu -N 1 --gres=gpu:tesla:1 --mem-per-cpu=256GB" --cluster-config /etc/xdg/snakemake/cubi-v1/config.yaml --jobs 10 --snakefile Snakefile_scvi #--dry-run
date
