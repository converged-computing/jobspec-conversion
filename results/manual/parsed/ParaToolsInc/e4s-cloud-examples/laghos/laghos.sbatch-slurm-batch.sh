#!/bin/bash
#SBATCH --job-name=laghos
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:05
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=4

export MV2_HOMOGENEOUS_CLUSTER='1'
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING='1'

export MV2_HOMOGENEOUS_CLUSTER=1
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING=1
spack load --first laghos
mpiexec laghos -p 1 -dim 2 -rs 3 -tf 0.8 -pa
