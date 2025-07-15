#!/bin/bash
#FLUX: --job-name=demux
#FLUX: -t=72000
#FLUX: --priority=16

echo 'Start'
snakemake \
    -r \
    --nt \
    --jobs 20 \
    --keep-going \
    --latency-wait 180 \
    --restart-times 0 \
    --profile=cubi-v1 \
    --cluster-config=/data/gpfs-1/users/cofu10_c/work/pipelines/umi-processing/config/cluster_config.yaml \
    --use-conda -p --rerun-incomplete --conda-prefix=/data/gpfs-1/users/cofu10_c/scratch/P3473/envs
echo 'Finished'
    #--dry-run \
    # --restart-times 2 \
    # --reason \
