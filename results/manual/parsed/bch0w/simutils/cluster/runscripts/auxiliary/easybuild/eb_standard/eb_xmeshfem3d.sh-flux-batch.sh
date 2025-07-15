#!/bin/bash
#FLUX: --job-name=xmeshfem3D
#FLUX: -N=2
#FLUX: -n=88
#FLUX: --queue=nesi_research
#FLUX: -t=300
#FLUX: --priority=16

COMPILER=SPECFEM3D/20190730-CrayCCE-19.04
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
COMPILER=SPECFEM3D/20190730-CrayIntel-19.04
module load ${COMPILER}
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
BASEMPIDIR=`grep ^LOCAL_PATH DATA/Par_file | cut -d = -f 2 `
mkdir -p ${BASEMPIDIR}
echo ${COMPILER}
echo "xmeshfem3D on ${NPROC} processors"
echo
echo "`date`"
time srun -n ${NPROC} xmeshfem3D
echo
echo "finished at: `date`"
