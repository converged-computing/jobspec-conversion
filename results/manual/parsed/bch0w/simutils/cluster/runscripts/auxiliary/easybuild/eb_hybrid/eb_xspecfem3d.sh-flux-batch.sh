#!/bin/bash
#FLUX: --job-name=xspecfem3D
#FLUX: -N=10
#FLUX: -n=40
#FLUX: -c=10
#FLUX: --queue=nesi_research
#FLUX: -t=120
#FLUX: --urgency=16

module load gcc/8.3.0
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
module load ${COMPILER}
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
BASEMPIDIR=`grep ^LOCAL_PATH DATA/Par_file | cut -d = -f 2 `
mkdir -p $BASEMPIDIR
echo ${COMPILER}
echo "xspecfem3d ${NPROC} processors"
echo
time srun -n ${NPROC} xspecfem3D
if [[ $? -ne 0 ]]; then exit 1; fi
echo
echo "finished at: `date`"
