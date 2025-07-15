#!/bin/bash
#FLUX: --job-name=demux
#FLUX: -t=72000
#FLUX: --priority=16

echo 'Start'
snakemake \
    -r \
    --nt \
    --jobs 40 \
    --keep-going \
    --restart-times 2 \
    --profile=cubi-v1 \
    --cluster-config ~/work/umi-data-processing/config/cluster_config.yaml \
    --use-conda -p --rerun-incomplete --conda-prefix=/fast/users/altwassr_c/work/conda-envs/
echo 'Finished'
    #--dry-run \
    # --restart-times 2 \
    # --reason \
