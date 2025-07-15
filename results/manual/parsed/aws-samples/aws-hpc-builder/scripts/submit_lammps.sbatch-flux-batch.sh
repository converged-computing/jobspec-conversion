#!/bin/bash
#FLUX: --job-name=hello-lettuce-1398
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=c6ipg
#FLUX: --priority=16

export LAMMPS_VERSION='git'
export OMP_NUM_THREADS='1'

export LAMMPS_VERSION=git
PREFIX=/fsx
source ${PREFIX}/scripts/env.sh 3 2
LOGDIR=${PREFIX}/log
LAMMPS_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_lammps-${LAMMPS_VERSION}.log
mkdir -p ${LOGDIR}
JOBDIR=${PREFIX}/spooler/lammps
mkdir -p ${JOBDIR}
cd ${JOBDIR}
ulimit -s unlimited
export OMP_NUM_THREADS=1
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
echo "Running lammps on $(date)"
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - lammps - ${HPC_COMPILER} - ${HPC_MPI}" >> ${LAMMPS_LOG} 2>&1
mpirun ${MPI_SHOW_BIND_OPTS} lmp -in cu.in >> ${LAMMPS_LOG} 2>&1
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - lammps - ${HPC_COMPILER} - ${HPC_MPI}" >> ${LAMMPS_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job lammps took ${JOB_FINISH_TIME} seconds($(echo "scale=5;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${LAMMPS_LOG} 2>&1
