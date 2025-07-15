#!/bin/bash
#FLUX: --job-name=ll_mpi
#FLUX: --queue=teach_cpu
#FLUX: -t=300
#FLUX: --priority=16

echo 'running mpi test'
module load languages/miniconda
echo "Before activation: $(which python)"
source activate desktop_clone_env
echo "After activation: $(which python)"
srun --mpi=pmi2 python mpi_numba.py 50 50 0.5 0
