#!/bin/bash
#FLUX: --job-name=simsopt
#FLUX: -c=4
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'

source ~/.bashrc
module load gcc/10.2.0
module load openmpi/gcc/64/4.1.5a1
module load anaconda
conda activate simsopt_072523
export OMP_NUM_THREADS=4
srun --mpi=pmix_v3 python trapped_map.py
