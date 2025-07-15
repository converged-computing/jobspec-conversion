#!/bin/bash
#FLUX: --job-name=creamy-cattywampus-7533
#FLUX: -N=2
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --priority=16

export ASAN_OPTIONS='protect_shadow_gap=0:use_sigaltstack=0'
export FI_HMEM_CUDA_USE_GDRCOPY='1'
export PMI_DIR='${DBS_DIR}'

module reset
module unload darshan
module load Nsight-Compute Nsight-Systems cudatoolkit craype-accel-nvidia80 gpu
module load python PrgEnv-gnu cray-fftw cray-hdf5-parallel cray-libsci
module load libfabric
TAG=`date '+%Y-%m-%d-%H%M'`-`uuidgen -t | head -c 4`
DBS_DIR=${HOME}/lib-PMI-4.1.2
MPI_DIR=${DBS_DIR}
HOME_DIR=${HOME}/rmem
SCRATCH_DIR=/pscratch/sd/t/tgillis/rmem_${TAG}_${SLURM_JOBID}
export ASAN_OPTIONS=protect_shadow_gap=0:use_sigaltstack=0
export FI_HMEM_CUDA_USE_GDRCOPY=1
echo "--------------------------------------------------"
echo "running in ${SCRATCH_DIR}"
echo "FI_CXI_RDZV_EAGER_SIZE = ${FI_CXI_RDZV_EAGER_SIZE}"
echo "FI_CXI_RDZV_THRESHOLD = ${FI_CXI_RDZV_THRESHOLD}"
echo "FI_CXI_RDZV_GET_MIN = ${FI_CXI_RDZV_GET_MIN}"
echo "--------------------------------------------------"
mkdir -p ${SCRATCH_DIR}
mkdir -p ${SCRATCH_DIR}/build
cd ${SCRATCH_DIR}
cp -r ${HOME_DIR}/src .
cp -r ${HOME_DIR}/make_arch .
cp -r ${HOME_DIR}/Makefile .
MPI_OPT="-n 2 -ppn 1 -l --bind-to core:2"
export PMI_DIR=${DBS_DIR}
for device in 0 1; do
    export USE_CUDA=${device}
    make clean
    make info debug
    ldd rmem
    #test delivery
    declare -a test=(
        "-r am -d am -c delivery"
        "-r am -d am -c fence"
        #"-r am -d am -c counter"
        #"-r am -d am -c cq_data"
        #"-r tag -d tag -c cq_data"
    )
    for RMEM_OPT in "${test[@]}"; do
        echo "==> ${MPI_OPT} with ${RMEM_OPT} - CUDA? ${USE_CUDA}"
        FI_PROVIDER="cxi" ${MPI_DIR}/bin/mpiexec ${MPI_OPT} ./rmem ${RMEM_OPT}
        #FI_PROVIDER="psm3" ${MPI_DIR}/bin/mpiexec ${MPI_OPT} ./rmem ${RMEM_OPT}
    done
done
