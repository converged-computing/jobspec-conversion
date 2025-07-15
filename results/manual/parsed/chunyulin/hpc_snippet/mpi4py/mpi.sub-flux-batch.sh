#!/bin/bash
#FLUX: --job-name=eccentric-diablo-2727
#FLUX: --priority=16

export UCX_LOG_LEVEL='error'

module purge
module load biology/Python/3.9.5
source ~/sandbox/bin/activate
module load compiler/intel/2020u4 OpenMPI/4.1.1
export UCX_LOG_LEVEL=error
mpirun -np ${SLURM_NTASKS} python3 mpi.py
