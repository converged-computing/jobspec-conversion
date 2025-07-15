#!/bin/bash
#FLUX: --job-name=idMissing
#FLUX: --queue=ckpt
#FLUX: -t=900
#FLUX: --urgency=16

export TZ='America/Los_Angeles'

pwd; hostname; date
echo "Running MATLAB script to identify failed simulations."
echo "${USRNAME}"
export USRNAME
echo "${DIRPATH}"
export DIRPATH
echo "${TCURR}"
export TCURR
echo "${DATE}"
export DATE
echo "${NSETS}"
export NSETS
cd ${DIRPATH}
export TZ="America/Los_Angeles"
module load matlab_2018a
mkdir -p /gscratch/csde/${USRNAME}/$SLURM_JOB_ID
matlab -nodisplay -nosplash -r "idMissingSets(${TCURR} , '${DATE}' , ${NSETS})"
rm -r /gscratch/csde/${USRNAME}/$SLURM_JOB_ID
date
