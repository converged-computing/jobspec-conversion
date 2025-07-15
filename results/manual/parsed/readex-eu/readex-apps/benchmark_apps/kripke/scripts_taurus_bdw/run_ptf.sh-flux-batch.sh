#!/bin/bash
#FLUX: --job-name=persnickety-fudge-3072
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=broadwell
#FLUX: --priority=16

export SCOREP_SUBSTRATE_PLUGINS='rrl'
export SCOREP_RRL_PLUGINS='cpu_freq_plugin,uncore_freq_plugin'
export SCOREP_RRL_VERBOSE='WARN'
export SCOREP_METRIC_PLUGINS='x86_energy_sync_plugin'
export SCOREP_METRIC_PLUGINS_SEP=';'
export SCOREP_METRIC_X86_ENERGY_SYNC_PLUGIN='*/E'
export SCOREP_METRIC_X86_ENERGY_SYNC_PLUGIN_CONNECTION='INBAND'
export SCOREP_METRIC_X86_ENERGY_SYNC_PLUGIN_VERBOSE='WARN'
export SCOREP_METRIC_X86_ENERGY_SYNC_PLUGIN_STATS_TIMEOUT_MS='1000'
export SCOREP_MPI_ENABLE_GROUPS='ENV'

cd ../build
. ../readex_env/set_env_ptf_rapl.source
. ../environment.sh
export SCOREP_SUBSTRATE_PLUGINS=rrl
export SCOREP_RRL_PLUGINS=cpu_freq_plugin,uncore_freq_plugin
export SCOREP_RRL_VERBOSE="WARN"
export SCOREP_METRIC_PLUGINS=x86_energy_sync_plugin
export SCOREP_METRIC_PLUGINS_SEP=";"
export SCOREP_METRIC_X86_ENERGY_SYNC_PLUGIN="*/E"
export SCOREP_METRIC_X86_ENERGY_SYNC_PLUGIN_CONNECTION="INBAND"
export SCOREP_METRIC_X86_ENERGY_SYNC_PLUGIN_VERBOSE="WARN"
export SCOREP_METRIC_X86_ENERGY_SYNC_PLUGIN_STATS_TIMEOUT_MS=1000
export SCOREP_MPI_ENABLE_GROUPS=ENV
psc_frontend --apprun="./kripke $KRIPKE_COMMAND" --mpinumprocs=28 --ompnumthreads=1 --phase="Loop" --info=2 --config-file=readex_config_extended.xml --tune=readex_intraphase  --force-localhost --selective-info=AutotunePlugins,FrontendStateMachines 2>&1 | tee -a log_JOB.txt
echo "running psc_frontend done"
