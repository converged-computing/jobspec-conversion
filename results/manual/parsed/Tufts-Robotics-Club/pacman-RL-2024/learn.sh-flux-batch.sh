#!/bin/bash
#FLUX: --job-name=PacLearn
#FLUX: -n=32
#FLUX: --queue=gpu,preempt
#FLUX: -t=21600
#FLUX: --urgency=16

module purge
hostname
module load anaconda/2021.05
module load cuda/12.2
module list
source activate cupy
python -m src
conda deactivate
