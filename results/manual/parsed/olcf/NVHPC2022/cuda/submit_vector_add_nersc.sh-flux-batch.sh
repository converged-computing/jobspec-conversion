#!/bin/bash
#FLUX: --job-name=crunchy-despacito-5769
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

module load PrgEnv-nvidia
module load cudatoolkit
srun ./vector_add
