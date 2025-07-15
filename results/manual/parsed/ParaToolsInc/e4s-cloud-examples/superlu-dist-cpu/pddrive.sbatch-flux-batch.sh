#!/bin/bash
#FLUX: --job-name=pddrive
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: --urgency=16

export MV2_HOMOGENEOUS_CLUSTER='1'
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING='1'
export MV2_ENABLE_AFFINITY='0'

spack load superlu-dist@8: ~cuda
export MV2_HOMOGENEOUS_CLUSTER=1
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING=1
export MV2_ENABLE_AFFINITY=0
srun --mpi=pmi2 ./pddrive -r 2 -c 2 g20.rua
