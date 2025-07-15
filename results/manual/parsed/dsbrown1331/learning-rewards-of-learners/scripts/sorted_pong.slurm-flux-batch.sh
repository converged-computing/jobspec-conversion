#!/bin/bash
#FLUX: --job-name=fat-gato-1301
#FLUX: --urgency=16

export TACC_LAUNCHER_PPN='1'
export EXECUTABLE='$TACC_LAUNCHER_DIR/init_launcher'
export WORKDIR='$WORK/Code/learning-rewards-of-learners/learner/'
export CONTROL_FILE='commands_pong'
export TACC_LAUNCHER_NPHI='0'
export TACC_LAUNCHER_PHI_PPN='8'
export PHI_WORKDIR='$WORK'
export PHI_CONTROL_FILE='phiparamlist'
export TACC_LAUNCHER_SCHED='interleaved'

module load launcher
module load tacc-singularity
export TACC_LAUNCHER_PPN=1
export EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
export WORKDIR=$WORK/Code/learning-rewards-of-learners/learner/
export CONTROL_FILE=commands_pong
export TACC_LAUNCHER_NPHI=0
export TACC_LAUNCHER_PHI_PPN=8
export PHI_WORKDIR=$WORK
export PHI_CONTROL_FILE=phiparamlist
export TACC_LAUNCHER_SCHED=interleaved
if [ ! -d $WORKDIR ]; then
        echo " "
        echo "Error: unable to change to working directory."
        echo "       $WORKDIR"
        echo " "
        echo "Job not submitted."
        exit
fi
if [ ! -x $EXECUTABLE ]; then
        echo " "
        echo "Error: unable to find launcher executable $EXECUTABLE."
        echo " "
        echo "Job not submitted."
        exit
fi
if [ ! -e $WORKDIR/$CONTROL_FILE ]; then
        echo " "
        echo "Error: unable to find input control file $CONTROL_FILE."
        echo " "
        echo "Job not submitted."
        exit
fi
cd $WORKDIR/
echo " WORKING DIR:   $WORKDIR/"
$TACC_LAUNCHER_DIR/paramrun SLURM $EXECUTABLE $WORKDIR $CONTROL_FILE $PHI_WORKDIR $PHI_CONTROL_FILE
echo " "
echo " Parameteric Job Complete"
echo " "
