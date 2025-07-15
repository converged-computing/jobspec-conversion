#!/bin/bash
#FLUX: --job-name=milky-leader-4994
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

module load PrgEnv-nvidia
module load cudatoolkit
srun ./laplace
