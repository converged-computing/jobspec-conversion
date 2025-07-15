#!/bin/bash
#FLUX: --job-name=test_FE
#FLUX: -t=1800
#FLUX: --priority=16

export I_MPI_FALLBACK='1'
export I_MPI_SHM_LMT='shm'

source /projects/misa5952/FastEddy/FastEddy_model/SRC/FEMAIN/setBeforeCompiling
export I_MPI_FALLBACK=1
export I_MPI_SHM_LMT=shm
module list
nvidia-smi > hhh
hostname
ulimit -s unlimited
FE=$PWD/SRC/FEMAIN/FastEddy
mpirun -np $SLURM_NTASKS $FE NBL_params.in
exit 0
