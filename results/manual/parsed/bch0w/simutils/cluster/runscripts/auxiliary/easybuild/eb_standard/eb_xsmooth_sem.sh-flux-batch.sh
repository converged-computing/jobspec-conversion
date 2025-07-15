#!/bin/bash
#FLUX: --job-name=xsmooth_sem
#FLUX: -N=4
#FLUX: -n=144
#FLUX: --queue=nesi_research
#FLUX: -t=1800
#FLUX: --priority=16

COMPILER=SPECFEM3D/20190730-CrayCCE-19.04
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
COMPILER=SPECFEM3D/20190730-CrayIntel-19.04
module load ${COMPILER}
KERNEL="vs"
SGMAH=40000.
SGMAV=1000.
DIR_IN="SMOOTH/"
DIR_OUT=${DIR_IN}
USE_GPU=".false"
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
echo ${COMPILER}
echo "xsmooth_sem ${KERNEL} w/ sigma_h=${SGMAH}, sigma_v=${SGMAV}"
echo "${NPROC} processors, GPU option: ${USE_GPU}"
echo
echo "`date`"
time srun -n ${NPROC} xsmooth_sem ${SGMAH} ${SGMAV} ${KERNEL} ${DIR_IN} ${DIR_OUT} ${USE_GPU}
if [[ $? -ne 0 ]]; then exit 1; fi
echo
echo "finished at: `date`"
