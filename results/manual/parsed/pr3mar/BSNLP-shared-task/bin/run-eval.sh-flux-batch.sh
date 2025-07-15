#!/bin/bash
#FLUX: --job-name="BSNLP-eval"
#FLUX: -c=4
#FLUX: -t=259200
#FLUX: --priority=16

CONTAINER_IMAGE_PATH="$PWD/containers/pytorch-image-new.sqfs"
echo "$SLURM_JOB_ID -> Generating the clusters for the model..."
BUNDLE="multi_all"
DIR_PREFIX="data/evals/$SLURM_JOB_ID-$BUNDLE"
mkdir -p "$DIR_PREFIX/reports"
mkdir -p "$DIR_PREFIX/error-logs"
mkdir -p "$DIR_PREFIX/summaries"
srun \
    --container-image "$CONTAINER_IMAGE_PATH" \
    --container-mounts "$PWD":/workspace,/shared/datasets/rsdo:/data \
    --container-entrypoint /workspace/bin/exec-eval.sh "java-eval/data-$BUNDLE" "$DIR_PREFIX/reports" "$DIR_PREFIX/error-logs" "$DIR_PREFIX/summaries"
echo "$SLURM_JOB_ID -> Done."
