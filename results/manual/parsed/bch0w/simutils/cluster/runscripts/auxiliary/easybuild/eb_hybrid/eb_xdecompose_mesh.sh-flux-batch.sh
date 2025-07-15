#!/bin/bash
#FLUX: --job-name=xdecompose_mesh
#FLUX: --queue=nesi_research
#FLUX: -t=60
#FLUX: --urgency=16

module load gcc/8.3.0
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
module load ${COMPILER}
MESH="./MESH"
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
BASEMPIDIR=`grep ^LOCAL_PATH DATA/Par_file | cut -d = -f 2 `
mkdir -p ${BASEMPIDIR}
echo ${COMPILER}
echo "xdecompose_mesh"
echo
echo "`date`"
xdecompose_mesh ${NPROC} ${MESH} ${BASEMPIDIR}
echo
echo "finished at: `date`"
