#!/bin/bash
#FLUX: --job-name=stanky-staircase-4011
#FLUX: --priority=16

export LAUNCHER_PLUGIN_DIR='$LAUNCHER_DIR/plugins'
export LAUNCHER_RMI='SLURM'
export LAUNCHER_WORKDIR='.'
export LAUNCHER_JOB_FILE='$WORK/setup_subject/run_setupfs.sh'

umask 2
module load launcher
module load fsl
module load freesurfer
module load matlab
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_WORKDIR=.
export LAUNCHER_JOB_FILE=$WORK/setup_subject/run_setupfs.sh
$LAUNCHER_DIR/paramrun
