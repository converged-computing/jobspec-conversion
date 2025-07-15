#!/bin/bash
#FLUX: --job-name=spicy-leg-8230
#FLUX: --priority=16

module purge
module load TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
module load matplotlib/3.5.2-foss-2022a
module load JupyterLab/3.5.0-GCCcore-11.3.0
jupyter lab
