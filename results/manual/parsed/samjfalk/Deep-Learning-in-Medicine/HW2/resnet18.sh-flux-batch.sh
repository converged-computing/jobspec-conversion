#!/bin/bash
#FLUX: --job-name=resnet18
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
source activate /home/sjf374/dl4med
srun python resnet18.py
