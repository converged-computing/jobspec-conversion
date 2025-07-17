#!/bin/bash
#FLUX: --job-name=frigid-muffin-6539
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=hpc6anpg
#FLUX: --urgency=16

export WRF_VERSION='3.9.1'
export JOB_DIR='${PREFIX}/spooler/wrf_sample_3.9'
export MKL_NUM_THREADS='4'
export OMP_NUM_THREADS='4'

PREFIX=/fsx
export WRF_VERSION=3.9.1
export JOB_DIR=${PREFIX}/spooler/wrf_sample_3.9
source ${PREFIX}/scripts/env.sh 3 2
LOGDIR=${PREFIX}/log
WRF_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_wrf-${WRF_VERSION}.log
mkdir -p ${LOGDIR}
ulimit -s unlimited
export MKL_NUM_THREADS=4
export OMP_NUM_THREADS=4
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
echo "Running WRF on $(date)"
cd ${JOB_DIR}
ln -sfn ${HPC_PREFIX}/${HPC_COMPILER}/${HPC_MPI}/WRF-${WRF_VERSION}/main/wrf.exe .
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - $(basename ${JOB_DIR}) - ${HPC_COMPILER} - ${HPC_MPI}" >> ${WRF_LOG} 2>&1
mpirun ${MPI_SHOW_BIND_OPTS} ./wrf.exe >> ${WRF_LOG} 2>&1
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - $(basename ${JOB_DIR}) - ${HPC_COMPILER} - ${HPC_MPI}" >> ${WRF_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job ${JOB_DIR} took ${JOB_FINISH_TIME} seconds($(echo "scale=2;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${WRF_LOG} 2>&1
