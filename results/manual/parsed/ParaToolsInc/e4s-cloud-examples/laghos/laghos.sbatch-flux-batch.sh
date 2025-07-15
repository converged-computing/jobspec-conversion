#!/bin/bash
#FLUX: --job-name=laghos
#FLUX: -N=2
#FLUX: -n=8
#FLUX: --exclusive
#FLUX: --urgency=16

export MV2_HOMOGENEOUS_CLUSTER='1'
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING='1'

export MV2_HOMOGENEOUS_CLUSTER=1
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING=1
spack load --first laghos
mpiexec laghos -p 1 -dim 2 -rs 3 -tf 0.8 -pa
