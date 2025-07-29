#!/bin/bash
#FLUX: --job-name=geant4_test
#FLUX: -N=2
#FLUX: -t=1200
#FLUX: --urgency=16

export LAUNCHER_DIR='/cluster/home/fabiobz/launcher'
export LAUNCHER_RMI='SLURM'
export LAUNCHER_PLUGIN_DIR='$LAUNCHER_DIR/plugins'
export LAUNCHER_WORKDIR='$workdir/OscarBuild/'
export LOGDIR='$workdir/logs'
export LAUNCHER_JOB_FILE='`pwd`/commands'
export LD_LIBRARY_PATH='/cluster/home/fabiobz/progs/xerces-c-3.2.3/install/lib:$LD_LIBRARY_PATH'

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
workdir=$USERWORK/$SLURM_JOB_ID
mkdir -p $workdir
cp -r /cluster/home/fabiobz/OCL_GEANT4/* $workdir
export LAUNCHER_DIR=/cluster/home/fabiobz/launcher
export LAUNCHER_RMI=SLURM
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_WORKDIR=$workdir/OscarBuild/
export LOGDIR=$workdir/logs
mkdir -p $LOGDIR
export LAUNCHER_JOB_FILE=`pwd`/commands
module load Python/3.8.2-GCCcore-9.3.0 ROOT/6.12.06-intel-2018a-Python-2.7.14 icc/2019.1.144-GCC-8.2.0-2.31.1 CMake/3.13.3-GCCcore-8.2.0
export LD_LIBRARY_PATH=/cluster/home/fabiobz/progs/xerces-c-3.2.3/install/lib:$LD_LIBRARY_PATH
source /cluster/home/fabiobz/progs/geant4.10.06.p02-install/bin/geant4.sh
module list 
$LAUNCHER_DIR/paramrun
