#!/bin/bash
#FLUX: --job-name=NER-l1o
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: -t=259200
#FLUX: --urgency=16

set -euo pipefail
CONTAINER_IMAGE_PATH="$PWD/containers/pytorch-image-new.sqfs"
echo "$SLURM_JOB_ID -> Training the model..."
srun \
    --container-image "$CONTAINER_IMAGE_PATH" \
    --container-mounts "$PWD":/workspace,/shared/datasets/rsdo:/data \
    --container-entrypoint /workspace/bin/exec-l1o.sh
echo "$SLURM_JOB_ID -> Done."
