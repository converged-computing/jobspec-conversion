#!/bin/bash
#SBATCH --job-name=BSNLP-eval
#SBATCH --output=logs/BSNLP-eval-%J.out
#SBATCH --error=logs/BSNLP-eval-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=5GB
#SBATCH --time=3-00:00:00

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
