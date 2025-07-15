#!/bin/bash
#FLUX: --job-name=orca_run
#FLUX: --queue=intel
#FLUX: --priority=16

export MODULEPATH='/opt/easybuild/modules/all'
export OMP_NUM_THREADS='4'
export ORCA_BIN='`which orca`'
export ORCA_2MKL_BIN='`which orca_2mkl`'

export MODULEPATH=/opt/easybuild/modules/all
module load ORCA/4.2.1-gompi-2019a
export OMP_NUM_THREADS=4
ulimit -n 4096
echo "Starting run"
ID=$SLURM_JOB_ID
mkdir /scratch/${ID}
shopt -s extglob
cp -r ${SLURM_SUBMIT_DIR}/!(slurm*.out) /scratch/${ID}/
shopt -u extglob
cd /scratch/${ID}
export ORCA_BIN=`which orca`
export ORCA_2MKL_BIN=`which orca_2mkl`
$ORCA_BIN orca_atom.inp > orca_atom.out
$ORCA_2MKL_BIN orca_atom -molden
cp -r * ${SLURM_SUBMIT_DIR}/
cd ${HOME}
rm -rf /scratch/${ID}
