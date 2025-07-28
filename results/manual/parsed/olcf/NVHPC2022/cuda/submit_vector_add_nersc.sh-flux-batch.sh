#!/bin/bash
#FLUX: --job-name=angry-muffin-4134
#FLUX: -c=128
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=300
#FLUX: --urgency=16

module load PrgEnv-nvidia
module load cudatoolkit
srun ./vector_add
