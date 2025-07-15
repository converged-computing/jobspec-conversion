#!/bin/bash
#FLUX: --job-name=parameter_search_job
#FLUX: --priority=16

docker1 run biohpc_wl428/xgb-shap-plt python /workdir/parameter_search.py $SLURM_ARRAY_TASK_ID
