#!/bin/bash
#SBATCH --job-name=NER-l1o
#SBATCH --output=logs/NER-l1o-%J.out
#SBATCH --error=logs/NER-l1o-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-task=1
#SBATCH --time=3-00:00:00

set -euo pipefail
CONTAINER_IMAGE_PATH="$PWD/containers/pytorch-image-new.sqfs"
echo "$SLURM_JOB_ID -> Training the model..."
srun \
    --container-image "$CONTAINER_IMAGE_PATH" \
    --container-mounts "$PWD":/workspace,/shared/datasets/rsdo:/data \
    --container-entrypoint /workspace/bin/exec-l1o.sh
echo "$SLURM_JOB_ID -> Done."
