#!/bin/bash
#FLUX: --job-name=arid-staircase-3964
#FLUX: -N=20
#FLUX: -t=43200
#FLUX: --priority=16

module load intelpython2
srun python pca.py
