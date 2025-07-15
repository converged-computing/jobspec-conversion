#!/bin/bash
#FLUX: --job-name=mnist
#FLUX: --queue=gpuq
#FLUX: -t=7200
#FLUX: --priority=16

nvidia-smi
module load gnu10
module load python
./scripts/train_dlee.sh
./scripts/test_dlee.sh
