#!/bin/bash
#FLUX: --job-name=spicy-lizard-3450
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

module load PrgEnv-nvidia
module load cudatoolkit
srun ./vector_add
