#!/bin/bash
#FLUX: --job-name=dask_square
#FLUX: -n=64
#FLUX: -t=300
#FLUX: --urgency=16

module --force purge
module load calcua/2020a
module load Python
module list
srun python dask_square.py
