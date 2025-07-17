#!/bin/bash
#FLUX: --job-name=kripke
#FLUX: --exclusive
#FLUX: --queue=broadwell
#FLUX: -t=120
#FLUX: --urgency=16

export SCOREP_PROFILING_FORMAT='cube_tuple'
export SCOREP_METRIC_PAPI='PAPI_TOT_INS,PAPI_L3_TCM'

cd ../build
. ../readex_env/set_env_rdd.source
. ../environment.sh
export SCOREP_PROFILING_FORMAT=cube_tuple
export SCOREP_METRIC_PAPI=PAPI_TOT_INS,PAPI_L3_TCM
echo "running kripke for readex-dyn-detect"
srun -n 28 ./kripke $KRIPKE_COMMAND
echo "running kripke done"
echo "running readex-dyn-detect"
echo "phase region = $2"
readex-dyn-detect -p "Loop" -t 0.01 scorep-*/profile.cubex
echo
echo "running readex-dyn-detect done" 
