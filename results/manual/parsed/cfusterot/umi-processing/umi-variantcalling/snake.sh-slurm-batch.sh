#!/bin/bash
#FLUX: --job-name=variantcalling
#FLUX: -t=518400
#FLUX: --urgency=16

snakemake \
    --nt \
    --jobs 60 \
    --cluster-config /data/gpfs-1/users/cofu10_c/work/pipelines/umi-processing/config/cluster_config.yaml \
    --profile=cubi-v1 \
    --restart-times 2 \
    --keep-going \
    --rerun-incomplete \
    --verbose \
    --use-conda \
    --conda-prefix=/data/gpfs-1/users/cofu10_c/scratch/P3473/envs/ 
    #--touch \
    #--skip-script-cleanup \
    #--reason 
    #--until annovar
    #--until table_to_anno \
