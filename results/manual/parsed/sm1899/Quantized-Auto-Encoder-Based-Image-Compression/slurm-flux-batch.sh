#!/bin/bash
#FLUX: --job-name=test3
#FLUX: -c=8
#FLUX: --queue=mtech
#FLUX: --urgency=16

module load python/3.10.pytorch
mpirun python3 /csehome/m23mac008/cvproject/draft.py >> test3.out
