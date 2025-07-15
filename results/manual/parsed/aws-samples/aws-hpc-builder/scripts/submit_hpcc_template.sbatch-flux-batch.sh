#!/bin/bash
#FLUX: --job-name=sticky-kerfuffle-6219
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=arm8xlarge
#FLUX: --urgency=16

export HPCC_VERSION='1.5.0'
export OMP_NUM_THREADS='1'

export HPCC_VERSION=1.5.0
PREFIX=XXPREFIXXX
source ${PREFIX}/scripts/env.sh 7 1
LOGDIR=${PREFIX}/log
HPCC_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_hpcc-${HPCC_VERSION}.log
mkdir -p ${LOGDIR}
JOBDIR=${PREFIX}/spooler/hpcc
mkdir -p ${JOBDIR}
cd ${JOBDIR}
ulimit -s unlimited
export OMP_NUM_THREADS=1
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
echo "Running hpcc on $(date)"
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - hpcc - ${HPC_COMPILER} - ${HPC_MPI}" >> ${HPCC_LOG} 2>&1
ln -sfn ${HPC_PREFIX}/${HPC_COMPILER}/${HPC_MPI}/hpcc-${HPCC_VERSION}/hpcc .
mpirun -n ${MPI_NUM_THREADS} ${MPI_SHOW_BIND_OPTS} ./hpcc >> ${HPCC_LOG} 2>&1
mv hpccoutf.txt hpccoutf_$(date +'%Y-%m-%d_%H-%M-%S').txt
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - hpcc - ${HPC_COMPILER} - ${HPC_MPI}" >> ${HPCC_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job hpcc took ${JOB_FINISH_TIME} seconds($(echo "scale=5;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${HPCC_LOG} 2>&1
