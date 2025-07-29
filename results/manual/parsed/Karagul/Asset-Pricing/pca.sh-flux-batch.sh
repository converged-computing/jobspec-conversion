#!/bin/bash
#FLUX --job-name=grated-cattywampus-4219
#FLUX -N=20
#FLUX -t=43200
#FLUX --urgency=16

module load intelpython2
srun python pca.py
