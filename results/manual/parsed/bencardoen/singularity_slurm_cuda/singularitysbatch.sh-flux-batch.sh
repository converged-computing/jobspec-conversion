#!/bin/bash
#FLUX: --job-name=adorable-lentil-1192
#FLUX: -c=6
#FLUX: -t=64800
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='$SLURM_TMPDIR/singularity/cache'
export SINGULARITY_TMPDIR='$SLURM_TMPDIR/singularity/tmp'

set -euo pipefail
NOW=$(date +"%m_%d_%Y_HH%I_%M")
echo "Starting setup at $NOW"
echo "Configuring Singularity"
module load singularity
module load cuda
export SINGULARITY_CACHEDIR="$SLURM_TMPDIR/singularity/cache"
export SINGULARITY_TMPDIR="$SLURM_TMPDIR/singularity/tmp"
mkdir -p $SINGULARITY_TMPDIR
mkdir -p $SINGULARITY_CACHEDIR
IMAGE_LOCATION="WHERE YOU SAVED THE SIF FILE"
echo "Copying Singularity image"
cp $IMAGE_LOCATION $SLURM_TMPDIR
echo "Running image"
srun singularity exec --nv $SLURM_TMPDIR/image.sif python -c 'import tensorflow as tf; assert(tf.test.is_gpu_available())'
NOW=$(date +"%m_%d_%Y_HH%I_%M")
echo "DONE at ${NOW}"
