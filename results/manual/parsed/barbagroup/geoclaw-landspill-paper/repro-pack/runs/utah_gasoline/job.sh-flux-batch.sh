#!/bin/bash
#FLUX: --job-name="Landspill Utah Gasoline"
#FLUX: --queue=defq
#FLUX: -t=86400
#FLUX: --priority=16

export HDF5_USE_FILE_LOCKING='FALSE'
export OMP_NUM_THREADS='20'

module use /lustre/groups/barbalab/modulefiles
module load singularity/3.4.2
module load singularity-collections/1.0.0
module list
IMAGE=${SINGULARITY_COLLECTIONS}/landspill-bionic.sif
ROOT_DIR=/lustre/groups/barbalab/pychuang/proposal-simulations/landspill-runs
CASE_NAME=utah_gasoline
CASE_DIR=${ROOT_DIR}/${CASE_NAME}
export HDF5_USE_FILE_LOCKING=FALSE
export OMP_NUM_THREADS=20
env > ${CASE_DIR}/env_vars.log
cd $CASE_DIR
echo "Currently running $CASE_NAME"
singularity run --app run ${IMAGE} ${CASE_DIR} > ${CASE_DIR}/stdout-${SLURM_JOBID}.log 2>&1 &
wait
