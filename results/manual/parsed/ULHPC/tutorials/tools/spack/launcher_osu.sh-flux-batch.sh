#!/bin/bash
#FLUX: --job-name=mpi_job_test
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=batch
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
OSU_VERSION="7.1-1"
OSU_ARCHIVE="osu-micro-benchmarks-${OSU_VERSION}.tar.gz"
OSU_URL="https://mvapich.cse.ohio-state.edu/download/mvapich/${OSU_ARCHIVE}"
if [[ ! -f ${OSU_ARCHIVE} ]];then 
    wget https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-7.1-1.tar.gz
    tar -xvf ${OSU_ARCHIVE} 
fi
spack load /xgcbqft
cd ${OSU_ARCHIVE//.tar.gz/}
./configure CC=$(which mpicc) CXX=$(which mpicxx)
make
cd ..
srun  ${OSU_ARCHIVE//.tar.gz/}/c/mpi/collective/blocking/osu_alltoall
