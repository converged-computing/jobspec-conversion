#!/bin/bash
#FLUX: --job-name=xsmooth_sem
#FLUX: -N=10
#FLUX: -n=40
#FLUX: -c=10
#FLUX: --queue=nesi_research
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='true'
export OMP_PLACES='cores'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=true
export OMP_PLACES=cores
module load gcc/8.3.0
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
module load ${COMPILER}
KERNEL="vs"
SGMAH=20000.
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
