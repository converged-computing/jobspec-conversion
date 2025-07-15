#!/bin/bash
#FLUX: --job-name=ll_mpi_numba_array
#FLUX: --queue=teach_cpu
#FLUX: -t=1800
#FLUX: --priority=16

echo 'running mpi test'
module load languages/miniconda
echo "Before activation: $(which python)"
source activate desktop_clone_env
echo "After activation: $(which python)"
size=$((SLURM_ARRAY_TASK_ID*75))
srun --mpi=pmi2 python LebwohlLasher_mpi_numba.py 50 $size 0.5 0
