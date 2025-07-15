#!/bin/bash
#FLUX: --job-name=liam4-5pvcr.qe
#FLUX: -n=100
#FLUX: --queue=amd
#FLUX: -t=720000
#FLUX: --priority=16

NPROC=100
CURDIR=$(pwd)
FNAME=liam4-5pvcr
cd ${CURDIR}
module load espresso/intel/6.8
mpirun -n ${NPROC} /tools/espresso-6.8/bin/pw.x -inp ${CURDIR}/${FNAME}.in >> ${CURDIR}/${FNAME}.out
if [[ ! -s ${FNAME}.e${SLURM_JOB_ID} ]]; then 
  rm - f ${FNAME}.e${SLURM_JOB_ID}
fi
exit 0
