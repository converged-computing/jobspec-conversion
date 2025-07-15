#!/bin/bash
#FLUX: --job-name=dirty-poodle-5609
#FLUX: --urgency=16

export MV2_ON_DEMAND_THRESHOLD='64'

export MV2_ON_DEMAND_THRESHOLD=64
ibrun ./ArcOn #-log_summary petsc_log_summary -ksp_view petsc_ksp_summary
   #ibrun ./ArcOn
