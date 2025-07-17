#!/bin/bash
#FLUX: --job-name=dinosaur-soup-9975
#FLUX: -n=16
#FLUX: -t=1200
#FLUX: --urgency=16

module purge
module purge
module load conda
eval "$(conda shell.bash hook)"
conda activate hpc-python
srun --mpi=pmix_v2 python3 ../examples/write_mpi_scatter.py -n 1000
