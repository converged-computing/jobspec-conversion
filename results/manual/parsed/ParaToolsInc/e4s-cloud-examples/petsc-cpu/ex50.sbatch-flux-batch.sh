#!/bin/bash
#FLUX: --job-name=ex50
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: --urgency=16

export MV2_HOMOGENEOUS_CLUSTER='1'
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING='1'

export MV2_HOMOGENEOUS_CLUSTER=1
export MV2_SUPPRESS_JOB_STARTUP_PERFORMANCE_WARNING=1
mpiexec ./ex50 \
  -da_grid_x 120 \
  -da_grid_y 120 \
  -pc_type lu \
  -pc_factor_mat_solver_type superlu_dist \
  -ksp_monitor \
  -ksp_view
