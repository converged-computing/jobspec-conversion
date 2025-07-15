#!/bin/bash
#FLUX: --job-name=butterscotch-carrot-1994
#FLUX: -n=4
#FLUX: -t=3600
#FLUX: --urgency=16

export PSM_RANKS_PER_CONTEXT='2'

set -eux
BUILD_DIR="_build"
POTFIT_REPO="https://github.com/potfit/potfit.git"
POTFIT_RELEASE="0.7.1"
POT_OPTION="potfit_mpi_tersoff_apot"
JOB_DIR="${HOME}/data/alpha20/25potfitaboron"
CONFIG_FILE="paramfile"
if [ -d ${BUILD_DIR} ]; then
    rm -rf ${BUILD_DIR}
fi
git clone ${POTFIT_REPO} ${BUILD_DIR}
cd ${BUILD_DIR}
git checkout tags/${POTFIT_RELEASE}
sed -i.bak -e 's/mpicc/mpiicc/' -e 's/^BIN_DIR/#&/' Makefile
module load intel
unset BIN_DIR
make ${POT_OPTION}
cp ${POT_OPTION} ${JOB_DIR}
cd ${JOB_DIR}
module load mpich/mpich-3.2-intel
export PSM_RANKS_PER_CONTEXT=2
mpirun -np ${SLURM_NTASKS} ./${POT_OPTION} ${CONFIG_FILE} | tee output
wait
