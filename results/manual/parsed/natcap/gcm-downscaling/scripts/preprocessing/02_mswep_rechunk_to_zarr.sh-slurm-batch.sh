#!/bin/bash
#SBATCH --output=/scratch/users/dfisher5/slurm-logfiles/slurm-%j.%x.out
#SBATCH --mail-user=davefisher@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=20000M
#SBATCH --time=08:00:00
#SBATCH --partition=hns,normal

CONTAINER=ghcr.io/natcap/gcm-downscaling:latest
WORKSPACE_DIR="$L_SCRATCH/$WORKSPACE_NAME"
set -x  # Be eXplicit about what's happening.
FAILED=0
singularity run \
    docker://$CONTAINER python scripts/preprocessing/02_mswep_rechunk_to_zarr.py \
    --n_workers=10 \
    --max_mem=20
