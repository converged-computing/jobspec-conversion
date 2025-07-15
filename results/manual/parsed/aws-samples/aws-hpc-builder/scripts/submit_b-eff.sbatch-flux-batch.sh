#!/bin/bash
#FLUX: --job-name=peachy-train-0074
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=c6gnpg
#FLUX: --priority=16

export B_EFF_VERSION='latest'

export B_EFF_VERSION=latest
PREFIX=/fsx
source ${PREFIX}/scripts/env.sh 1 0
LOGDIR=${PREFIX}/log
B_EFF_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_b_eff-${B_EFF_VERSION}.log
mkdir -p ${LOGDIR}
JOBDIR=${PREFIX}/spooler/b-eff
cd ${JOBDIR}
ln -sfn ${HPC_PREFIX}/${HPC_COMPILER}/${HPC_MPI}/b_eff-${B_EFF_VERSION}/b_eff .
ulimit -s unlimited
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
echo "Running b_eff on $(date)"
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - b_eff - ${HPC_COMPILER} - ${HPC_MPI}" >> ${B_EFF_LOG} 2>&1
mpirun ${MPI_SHOW_BIND_OPTS} ./b_eff >> ${B_EFF_LOG} 2>&1
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - b_eff - ${HPC_COMPILER} - ${HPC_MPI}" >> ${B_EFF_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job b_eff took ${JOB_FINISH_TIME} seconds($(echo "scale=5;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${B_EFF_LOG} 2>&1
