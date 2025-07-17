#!/bin/bash
#FLUX: --job-name=poisson
#FLUX: -n=4
#FLUX: -c=7
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load anaconda3
conda activate myenv
nvidia-smi
