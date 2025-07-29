#!/bin/bash
#SBATCH --job-name=launch
#SBATCH --account=Analysis_Lonestar
#SBATCH --output=setup_sub_fs_137
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

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
