#!/bin/bash
#FLUX: --job-name=reclusive-muffin-9743
#FLUX: -n=16
#FLUX: -t=1200
#FLUX: --urgency=16

module purge
module purge
module load conda
eval "$(conda shell.bash hook)"
conda activate hpc-python
srun --mpi=pmix_v2 python3 ../examples/write_final.py -n 1000
