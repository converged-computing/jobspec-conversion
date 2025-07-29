#!/bin/bash
#SBATCH --job-name=NER-BERT-setup
#SBATCH --output=logs/NER-BERT-setup-%J.out
#SBATCH --error=logs/NER-BERT-setup-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=00:05:00

set -euo pipefail
CONTAINER_IMAGE_PATH="$PWD/containers/pytorch-image-new.sqfs"
if [ ! -e "$CONTAINER_IMAGE_PATH" ]; then
    echo "Creating the container image at $CONTAINER_IMAGE_PATH..."
    # xantipa uses Singularity containers, we need the appropriate image
    # singularity build ./containers/sing-container.sif docker://pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime
    srun \
        --container-image pytorch/pytorch:1.7.0-cuda11.0-cudnn8-runtime \
        --container-save "$CONTAINER_IMAGE_PATH" \
        --container-mounts "$PWD":/workspace \
        --container-entrypoint /workspace/bin/exec-setup.sh
    echo "Image is created."
else
    echo "Using existing image from $CONTAINER_IMAGE_PATH."
fi
