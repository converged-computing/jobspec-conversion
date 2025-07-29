#!/bin/bash
#SBATCH --job-name=kripke
#SBATCH --account=p_readex
#SBATCH --mail-user=ondrej.vysocky@vsb.cz
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2200M
#SBATCH --time=00:01:00
#SBATCH --partition=broadwell
#SBATCH: --exclusive

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
srun -n 28 ./kripke $KRIPKE_COMMAND
echo "running for RRL done"
