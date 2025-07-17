#!/bin/bash
#FLUX: --job-name=ArcOn_ITER
#FLUX: -n=64
#FLUX: --queue=development
#FLUX: -t=900
#FLUX: --urgency=16

export MV2_ON_DEMAND_THRESHOLD='64'

export MV2_ON_DEMAND_THRESHOLD=64
ibrun ./ArcOn #-log_summary petsc_log_summary -ksp_view petsc_ksp_summary
   #ibrun ./ArcOn
