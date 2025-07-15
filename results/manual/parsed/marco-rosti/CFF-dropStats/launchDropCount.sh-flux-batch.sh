#!/bin/bash
#FLUX: --job-name=dropCount
#FLUX: -n=250
#FLUX: --queue=short
#FLUX: -t=7200
#FLUX: --priority=16

ulimit -s unlimited
srun --mpi=pmix ./drop_count
module load python
python combineOutputs.py
