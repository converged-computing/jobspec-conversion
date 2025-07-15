#!/bin/bash
#FLUX: --job-name=doopy-hippo-6332
#FLUX: --priority=16

export MV2_ON_DEMAND_THRESHOLD='64'

export MV2_ON_DEMAND_THRESHOLD=64
ibrun ./ArcOn #-log_summary petsc_log_summary -ksp_view petsc_ksp_summary
   #ibrun ./ArcOn
