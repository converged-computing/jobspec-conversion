#!/bin/bash
#FLUX: --job-name=peachy-peanut-butter-8732
#FLUX: -t=21600
#FLUX: --priority=16

module purge
hostname
module load anaconda/2021.05
module load cuda/12.2
module list
source activate cupy
python -m src
conda deactivate
