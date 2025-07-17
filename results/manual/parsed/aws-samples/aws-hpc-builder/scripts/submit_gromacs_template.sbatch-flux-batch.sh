#!/bin/bash
#FLUX: --job-name=wobbly-platanos-1866
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=c6i
#FLUX: --urgency=16

export GROMACS_VERSION='2022.4'
export JOB_DIR='${PREFIX}/spooler/gromacs'
export JOB_INPUT='test_aws.tpr'

PREFIX=XXPREFIXXX
export GROMACS_VERSION=2022.4
export JOB_DIR=${PREFIX}/spooler/gromacs
export JOB_INPUT="test_aws.tpr"
source ${PREFIX}/scripts/env.sh 1 0
LOGDIR=${PREFIX}/log
GROMACS_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_gromacs-${GROMACS_VERSION}.log
mkdir -p ${LOGDIR}
NTOMP=2
NSTEPS=20000
ulimit -s unlimited
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
echo "Running GROMACS on $(date)"
cd ${JOB_DIR}
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - $(basename ${JOB_DIR}) - ${HPC_COMPILER} - ${HPC_MPI}" >> ${GROMACS_LOG} 2>&1
mpirun ${MPI_SHOW_BIND_OPTS} gmx_mpi mdrun -nsteps ${NSTEPS} -ntomp ${NTOMP} -s ${JOB_INPUT} >> ${GROMACS_LOG} 2>&1
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - $(basename ${JOB_DIR}) - ${HPC_COMPILER} - ${HPC_MPI}" >> ${GROMACS_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job ${JOB_DIR} took ${JOB_FINISH_TIME} seconds($(echo "scale=5;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${GROMACS_LOG} 2>&1
