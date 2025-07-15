#!/bin/bash
#FLUX: --job-name=GPUJob
#FLUX: --urgency=16

module load miniconda/3
module load cuda
source activate recon
srun nvidia-smi
python cuda.py
