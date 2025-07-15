#!/bin/bash
#FLUX: --job-name=xgenerate_databases
#FLUX: -N=2
#FLUX: -n=10
#FLUX: -c=8
#FLUX: --queue=nesi_research
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_COUS_PER_TASK'
export OMP_PROC_BIND='true'
export OMP_PLACES='cores'

export OMP_NUM_THREADS=$SLURM_COUS_PER_TASK
export OMP_PROC_BIND=true
export OMP_PLACES=cores
COMPILER=SPECFEM3D/20190730-CrayCCE-19.04
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
COMPILER=SPECFEM3D/20190730-CrayIntel-19.04
module load ${COMPILER}
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
BASEMPIDIR=`grep ^LOCAL_PATH DATA/Par_file | cut -d = -f 2 `
mkdir -p ${BASEMPIDIR}
echo ${COMPILER}
echo "xgenerate_databases ${NPROC} processors"
echo
echo "`date`"
time srun -n ${NPROC} xgenerate_databases
if [[ $? -ne 0 ]]; then exit 1; fi
echo
echo "finished at: `date`"
