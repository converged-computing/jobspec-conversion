#!/bin/bash
#FLUX: --job-name=hairy-butter-3956
#FLUX: -t=14400
#FLUX: --priority=16

set -eu
module load lib/NCCL/2.12.12-GCCcore-11.3.0-CUDA-11.7.0
module load ai/PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module load vis/torchvision/0.13.1-foss-2022a-CUDA-11.7.0
source mst5-venv/bin/activate
bash eval.sh "$@"
