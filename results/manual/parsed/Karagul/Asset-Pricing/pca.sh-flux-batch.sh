#!/bin/bash
#FLUX: --job-name=anxious-banana-8310
#FLUX: -N=20
#FLUX: -t=43200
#FLUX: --urgency=16

module load intelpython2
srun python pca.py
