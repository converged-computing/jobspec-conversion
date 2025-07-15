#!/bin/bash
#FLUX: --job-name=crusty-eagle-7530
#FLUX: --queue=cp3
#FLUX: -t=4800
#FLUX: --priority=16

export JOBID='$SLURM_ARRAY_JOB_ID'
export TASKID='$SLURM_ARRAY_TASK_ID'
export SINGULARITYENV_PATH='$PATH'
export SINGULARITYENV_LD_LIBRARY_PATH='$LD_LIBRARY_PATH'

START=`date +%s`
echo "Job start at `date`"
echo "Running job on machine `uname -a`, host $HOSTNAME"
function peval { echo ">>> $@"; eval "$@"; }
export JOBID=$SLURM_ARRAY_JOB_ID
export TASKID=$SLURM_ARRAY_TASK_ID
if [[ "$HOME" == *"ucl"* ]]
then 
   export WORKDIR="/nfs/scratch/fynu/$USER/$JOBID.$TASKID"
else 
   export WORKDIR="/scratch/$USER/$JOBID.$TASKID"
fi
JOBLIST=$1
echo "\$JOBID=$JOBID"
echo "\$TASKID=$TASKID"
echo "\$SLURM_JOB_ID=$SLURM_JOB_ID"
echo "\$HOSTNAME=$HOSTNAME"
echo "\$JOBLIST=$JOBLIST"
echo "\$SBATCH_TIMELIMIT=$SBATCH_TIMELIMIT"
echo "\$WORKDIR=$WORKDIR"
echo "\$TMPDIR=$TMPDIR"
echo "\$PWD=$PWD"
peval 'TASKCMD=$(cat $JOBLIST | sed "${TASKID}q;d")'
peval "mkdir $WORKDIR"
peval "cd $WORKDIR"
echo "cmssw = $CMSSW_BASE"
export SINGULARITYENV_PATH=$PATH
export SINGULARITYENV_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
singularity exec /cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/el7:x86_64 /bin/sh <<- EOF_PAYLOAD
echo ">>> $TASKCMD"
eval "$TASKCMD"
EOF_PAYLOAD
peval "cd -"
peval "rm -rf $WORKDIR"
echo
END=`date +%s`; RUNTIME=$((END-START))
echo "Job complete at `date`"
printf "Took %d minutes %d seconds" "$(( $RUNTIME / 60 ))" "$(( $RUNTIME % 60 ))"
