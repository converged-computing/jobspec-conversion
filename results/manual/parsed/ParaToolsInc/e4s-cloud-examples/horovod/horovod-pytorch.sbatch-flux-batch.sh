#!/bin/bash
#FLUX: --job-name=hvd-torch
#FLUX: -N=2
#FLUX: -n=72
#FLUX: --exclusive
#FLUX: --priority=16

export MV2_HOMOGENEOUS_CLUSTER='1'
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING='1'

export MV2_HOMOGENEOUS_CLUSTER=1
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING=1
mpiexec python3 src/pytorch_mnist.py --epochs 2 --no-cuda
