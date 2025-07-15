#!/bin/bash
#FLUX: --job-name=adorable-motorcycle-8855
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=g16xlargeefa
#FLUX: --urgency=16

export OSU_VERSION='6.1'

export OSU_VERSION=6.1
PREFIX=/fsx
source ${PREFIX}/scripts/env.sh 6 0
LOGDIR=${PREFIX}/log
OSU_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_osu-${OSU_VERSION}.log
mkdir -p ${LOGDIR}
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
ulimit -s unlimited
echo "Running osu on $(date)"
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - osu - ${HPC_COMPILER} - ${HPC_MPI}" >> ${OSU_LOG} 2>&1
mpirun ${MPI_SHOW_BIND_OPTS} ${HPC_PREFIX}/${HPC_COMPILER}/${HPC_MPI}/osu-micro-benchmarks-${OSU_VERSION}/c/mpi/pt2pt/osu_latency >> ${OSU_LOG} 2>&1
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - osu - ${HPC_COMPILER} - ${HPC_MPI}" >> ${OSU_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job osu took ${JOB_FINISH_TIME} seconds($(echo "scale=5;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${OSU_LOG} 2>&1
