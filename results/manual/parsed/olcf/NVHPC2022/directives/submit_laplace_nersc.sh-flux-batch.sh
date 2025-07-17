#!/bin/bash
#FLUX: --job-name=delicious-malarkey-2590
#FLUX: -c=128
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=300
#FLUX: --urgency=16

module load PrgEnv-nvidia
module load cudatoolkit
srun ./laplace
