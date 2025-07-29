#!/bin/bash
#FLUX: --job-name=equiformer
#FLUX: -c=8
#FLUX: -t=108000
#FLUX: --urgency=16

export SCRIPTDIR='${HOME_DIR}/equilibrium-forcefields/equiformer'

echo `date`: Job $SLURM_JOB_ID is allocated resources.
echo "Inside slurm_launcher.slrm ($0). received arguments: $@"
HOME_DIR=/home/andreasburger
export SCRIPTDIR=${HOME_DIR}/equilibrium-forcefields/equiformer
if [[ $1 == *"test"* ]]; then
    echo "Found test in the filename. Changing the scriptdir to equilibrium-forcefields/tests"
    export SCRIPTDIR=${HOME_DIR}/equilibrium-forcefields/tests
elif [[ $1 == *"deq"* ]]; then
    echo "Found deq in the filename. Changing the scriptdir to equilibrium-forcefields/scripts"
    export SCRIPTDIR=${HOME_DIR}/equilibrium-forcefields/scripts
fi
echo "Submitting ${SCRIPTDIR}/$@"
${HOME_DIR}/miniforge3/envs/deq/bin/python ${SCRIPTDIR}/"$@"
