#!/bin/bash
#SBATCH --job-name=amg2013_ptf
#SBATCH --account=p_readex
#SBATCH --output=amg2013_ptf.out
#SBATCH --error=amg2013_ptf.out
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=2500M
#SBATCH --time=1-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=2

export PSC_CPU_BIND='--cpu_bind=verbose,sockets'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/lib'
export SCOREP_SUBSTRATE_PLUGINS='rrl'
export SCOREP_RRL_PLUGINS='cpu_freq_plugin,uncore_freq_plugin,OpenMPTP'
export SCOREP_RRL_VERBOSE='WARN'
export SCOREP_METRIC_PLUGINS='hdeem_sync_plugin'
export SCOREP_METRIC_HDEEM_SYNC_PLUGIN='*/E'
export SCOREP_METRIC_PLUGINS_SEP=';'
export SCOREP_METRIC_HDEEM_SYNC_PLUGIN_CONNECTION='INBAND'
export SCOREP_METRIC_HDEEM_SYNC_PLUGIN_VERBOSE='WARN'
export SCOREP_METRIC_HDEEM_SYNC_PLUGIN_STATS_TIMEOUT_MS='1000'
export SCOREP_MPI_ENABLE_GROUPS='ENV'
export OMP_NUM_THREADS='12'

cd ..
module purge
source ./readex_env/set_env_ptf_hdeem.source
export PSC_CPU_BIND="--cpu_bind=verbose,sockets"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export SCOREP_SUBSTRATE_PLUGINS=rrl
export SCOREP_RRL_PLUGINS=cpu_freq_plugin,uncore_freq_plugin,OpenMPTP
export SCOREP_RRL_VERBOSE="WARN"
export SCOREP_METRIC_PLUGINS=hdeem_sync_plugin
export SCOREP_METRIC_HDEEM_SYNC_PLUGIN="*/E"
export SCOREP_METRIC_PLUGINS_SEP=";"
export SCOREP_METRIC_HDEEM_SYNC_PLUGIN_CONNECTION="INBAND"
export SCOREP_METRIC_HDEEM_SYNC_PLUGIN_VERBOSE="WARN"
export SCOREP_METRIC_HDEEM_SYNC_PLUGIN_STATS_TIMEOUT_MS=1000
export SCOREP_MPI_ENABLE_GROUPS=ENV
export OMP_NUM_THREADS=12
PHASE=main_phase
psc_frontend --apprun="./test/amg2013_ptf -P 2 2 2 -r 40 40 40" --mpinumprocs=8 --ompnumthreads=12 --phase=$PHASE --tune=readex_intraphase --config-file=readex_config_ptf.xml --force-localhost --info=2 --selective-info=AutotuneAll,AutotunePlugins
