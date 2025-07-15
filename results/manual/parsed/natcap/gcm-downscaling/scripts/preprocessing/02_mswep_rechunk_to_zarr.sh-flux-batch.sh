#!/bin/bash
#FLUX: --job-name=eccentric-avocado-1574
#FLUX: -c=10
#FLUX: --queue=hns,normal
#FLUX: -t=28800
#FLUX: --priority=16

CONTAINER=ghcr.io/natcap/gcm-downscaling:latest
WORKSPACE_DIR="$L_SCRATCH/$WORKSPACE_NAME"
set -x  # Be eXplicit about what's happening.
FAILED=0
singularity run \
    docker://$CONTAINER python scripts/preprocessing/02_mswep_rechunk_to_zarr.py \
    --n_workers=10 \
    --max_mem=20
