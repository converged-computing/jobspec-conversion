#!/bin/bash
#FLUX: --job-name=goodbye-ricecake-6799
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=gxlarge
#FLUX: --urgency=16

export IOR_VERSION='4.0.0rc1'
export OMP_NUM_THREADS='1'

export IOR_VERSION=4.0.0rc1
PREFIX=XXPREFIXXX
source ${PREFIX}/scripts/env.sh 6 0
LOGDIR=${PREFIX}/log
IOR_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_ior-${IOR_VERSION}.log
mkdir -p ${LOGDIR}
JOBDIR=${PREFIX}/spooler/ior
mkdir -p ${JOBDIR}
cd ${JOBDIR}
ulimit -s unlimited
export OMP_NUM_THREADS=1
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
echo "Running ior on $(date)"
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - ior - ${HPC_COMPILER} - ${HPC_MPI}" >> ${IOR_LOG} 2>&1
mpirun ${MPI_SHOW_BIND_OPTS} ior --posix.odirect -t 1m -b 16m -s 200 -F >> ${IOR_LOG} 2>&1
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - ior - ${HPC_COMPILER} - ${HPC_MPI}" >> ${IOR_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job ior took ${JOB_FINISH_TIME} seconds($(echo "scale=5;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${IOR_LOG} 2>&1
