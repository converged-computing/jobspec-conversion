#!/bin/bash
#FLUX: --job-name=quirky-buttface-0242
#FLUX: --exclusive
#FLUX: --queue=haswell
#FLUX: -t=1800
#FLUX: --urgency=16

export SCOREP_SUBSTRATE_PLUGINS='rrl'
export SCOREP_RRL_VERBOSE='WARN'
export SCOREP_RRL_PLUGINS='cpu_freq_plugin,uncore_freq_plugin'
export SCOREP_RRL_TMM_PATH='tuning_model.json'
export SCOREP_ENABLE_TRACING='false'
export SCOREP_ENABLE_PROFILING='false'
export SCOREP_MPI_ENABLE_GROUPS='ENV'

cd ../build
. ../readex_env/set_env_rrl.source
. ../environment.sh
export SCOREP_SUBSTRATE_PLUGINS='rrl'
export SCOREP_RRL_VERBOSE="WARN"
export SCOREP_RRL_PLUGINS=cpu_freq_plugin,uncore_freq_plugin
export SCOREP_RRL_TMM_PATH=tuning_model.json
export SCOREP_ENABLE_TRACING=false
export SCOREP_ENABLE_PROFILING=false
export SCOREP_MPI_ENABLE_GROUPS=ENV
echo "running for RRL"
srun -n 24 ./kripke $KRIPKE_COMMAND
clearHdeem
startHdeem
srun -n 24 ./kripke $KRIPKE_COMMAND
stopHdeem
checkHdeem
echo "running for RRL done"
