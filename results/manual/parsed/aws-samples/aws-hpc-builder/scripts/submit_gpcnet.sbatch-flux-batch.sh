#!/bin/bash
#FLUX: --job-name=loopy-earthworm-0835
#FLUX: -N=10
#FLUX: --exclusive
#FLUX: --queue=c7gnpg
#FLUX: --priority=16

export GPCNET_VERSION='git'

export GPCNET_VERSION=git
PREFIX=/fsx
source ${PREFIX}/scripts/env.sh 1 0
LOGDIR=${PREFIX}/log
GPCNET_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_gpcnet-${GPCNET_VERSION}.log
mkdir -p ${LOGDIR}
ulimit -s unlimited
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
echo "Running gpcnet on $(date)"
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - gpcnet - ${HPC_COMPILER} - ${HPC_MPI}" >> ${GPCNET_LOG} 2>&1
mpirun ${MPI_SHOW_BIND_OPTS} ${HPC_PREFIX}/${HPC_COMPILER}/${HPC_MPI}/GPCNET-${GPCNET_VERSION}/network_test >> ${GPCNET_LOG} 2>&1
mpirun ${MPI_SHOW_BIND_OPTS} ${HPC_PREFIX}/${HPC_COMPILER}/${HPC_MPI}/GPCNET-${GPCNET_VERSION}/network_load_test >> ${GPCNET_LOG} 2>&1
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - gpcnet - ${HPC_COMPILER} - ${HPC_MPI}" >> ${GPCNET_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job gpcnet took ${JOB_FINISH_TIME} seconds($(echo "scale=5;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${GPCNET_LOG} 2>&1
