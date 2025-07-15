#!/bin/bash
#FLUX: --job-name="dy-dist"
#FLUX: -c=2
#FLUX: --queue=peregrine-gpu
#FLUX: -t=36000
#FLUX: --priority=16

module purge
module load python/anaconda
srun python DistributedTraining.py
