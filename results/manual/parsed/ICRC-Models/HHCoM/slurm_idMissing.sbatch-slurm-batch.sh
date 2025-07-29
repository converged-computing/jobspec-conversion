#!/bin/bash
#SBATCH --job-name=idMissing
#SBATCH --account=csde-ckpt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=00:15:00
#SBATCH --partition=ckpt
#SBATCH --constraint=ntasks-per-node=1

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
