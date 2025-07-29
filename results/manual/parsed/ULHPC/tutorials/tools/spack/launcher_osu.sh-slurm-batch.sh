#!/bin/bash
#SBATCH --job-name=mpi_job_test
#SBATCH --output=mpi_test_%j.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=128

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
