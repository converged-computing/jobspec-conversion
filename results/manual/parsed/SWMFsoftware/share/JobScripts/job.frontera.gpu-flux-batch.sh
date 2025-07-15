#!/bin/bash
#FLUX: --job-name=psycho-cattywampus-7232
#FLUX: --priority=16

export I_MPI_ADJUST_REDUCE='1 '
export UCX_LOG_LEVEL='ERROR '
export OPAL_PREFIX='/scratch1/projects/compilers/nvhpc20v7/Linux_x86_64/20.7/comm_libs/mpi'

export I_MPI_ADJUST_REDUCE=1 
export UCX_LOG_LEVEL=ERROR 
export OPAL_PREFIX=/scratch1/projects/compilers/nvhpc20v7/Linux_x86_64/20.7/comm_libs/mpi
mpirun -n 1 ./SWMF.exe  > runlog_`date +%y%m%d%H%M`
