#!/bin/bash
#SBATCH --job-name=pddrive
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:02
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=2

export MV2_HOMOGENEOUS_CLUSTER='1'
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING='1'
export MV2_ENABLE_AFFINITY='0'

spack load superlu-dist@8: ~cuda
export MV2_HOMOGENEOUS_CLUSTER=1
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING=1
export MV2_ENABLE_AFFINITY=0
srun --mpi=pmi2 ./pddrive -r 2 -c 2 g20.rua
