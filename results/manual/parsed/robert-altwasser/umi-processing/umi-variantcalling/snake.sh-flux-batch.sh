#!/bin/bash
#FLUX: --job-name=variantcalling
#FLUX: -t=518400
#FLUX: --priority=16

snakemake \
    --nt \
    --jobs 60 \
    --cluster-config ~/work/umi-data-processing/config/cluster_config.yaml \
    --profile=cubi-v1 \
    --restart-times 2 \
    --keep-going \
    --dry-run \
    --rerun-incomplete \
    --use-conda --conda-prefix=/fast/users/altwassr_c/work/conda-envs/
