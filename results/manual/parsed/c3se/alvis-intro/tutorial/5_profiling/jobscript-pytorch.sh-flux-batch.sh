#!/bin/bash
#FLUX: --job-name=evasive-parrot-1165
#FLUX: --urgency=16

module purge
module load PyTorch-bundle/1.12.1-foss-2022a-CUDA-11.7.0
module load matplotlib/3.5.2-foss-2022a
module load JupyterLab/3.5.0-GCCcore-11.3.0
jupyter lab
