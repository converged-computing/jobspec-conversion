#!/bin/bash
#FLUX: --job-name=bricky-milkshake-6151
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

module load PrgEnv-nvidia
module load cudatoolkit
srun ./laplace
