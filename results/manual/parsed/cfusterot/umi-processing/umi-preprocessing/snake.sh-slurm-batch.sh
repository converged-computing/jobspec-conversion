#!/bin/bash
#FLUX: --job-name=preprocessing
#FLUX: -t=86400
#FLUX: --urgency=16

snakemake \
    --nt \
    --jobs 250 \
    --restart-times 3 \
    --cluster-config /data/gpfs-1/users/cofu10_c/work/pipelines/umi-processing/config/cluster_config.yaml \
    --profile=cubi-v1 \
    --use-conda \
    --conda-frontend mamba \
    --printshellcmds \
    --rerun-incomplete \
    --scheduler greedy \
    --keep-going \
    --conda-prefix=/data/gpfs-1/users/cofu10_c/scratch/P3406/envs \
    --reason \
    --verbose \
    --keep-going \
