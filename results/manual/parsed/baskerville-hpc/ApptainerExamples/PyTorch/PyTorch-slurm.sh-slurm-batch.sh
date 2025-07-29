#!/bin/bash
#FLUX: --job-name=nvidia-smi
#FLUX: -t=30
#FLUX: --urgency=16

module purge
module load baskerville
module load CUDA/11.3.1 
unset APPTAINER_BIND
apptainer run --nv PyTorch.sif
