#!/bin/bash
#FLUX: --job-name=buttery-ricecake-3469
#FLUX: --urgency=16

export LAUNCHER_PLUGIN_DIR='$LAUNCHER_DIR/plugins'
export LAUNCHER_RMI='SLURM'
export LAUNCHER_JOB_FILE='$taskfilename'

module load intel/18.0.2 cmake/3.7.1 gsl boost hdf5 eigen impi python3 launcher
source ../../jf_prepare.sh
module list
inputdir=../input-config #where the tables for iS3D, smash... are located. design_pts should be a folder inside!   
job=$SLURM_JOB_ID
num_design_pts=50
num_events_per_design=500
let max_design=$num_design_pts-1
let max_events=$num_events_per_design-1
taskfilename=tasks-$job
cat submit_launcher_design_new_norm > job_history/$job
for j in $(seq 0 $max_events)
do
    for i in $(seq 0 $max_design)
    do
	echo run-events-design-new --nevents 1 --logfile $SCRATCH/logs/$job/$i/$j.log --tmpdir=/tmp --tablesdir=$inputdir --startdir=$inputdir/design_pts/validation/PbPb-2760/$i $SCRATCH/results/$job/$i/$j.dat >> $taskfilename
    done
done
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE=$taskfilename
$LAUNCHER_DIR/paramrun
