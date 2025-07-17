#!/bin/bash
#FLUX: --job-name=placid-kerfuffle-7507
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: --queue=standard-g
#FLUX: -t=21600
#FLUX: --urgency=16

export HIPCC_COMPILE_FLAGS_APPEND='--offload-arch=gfx90a $(CC --cray-print-opts=cflags)'
export HIPCC_LINK_FLAGS_APPEND='$(CC --cray-print-opts=libs)'
export ASAN_OPTIONS='protect_shadow_gap=0:use_sigaltstack=0'
export TSAN_OPTIONS='second_deadlock_stack=1'
export FI_HMEM_CUDA_USE_GDRCOPY='1'
export FI_CXI_OPTIMIZED_MRS='1'
export PMI_DIR='${DBS_DIR}'

echo "loading modules"
module load PrgEnv-gnu-amd
module load libfabric/1.15.2.0
module list
TAG=`date '+%Y-%m-%d-%H%M'`-`uuidgen -t | head -c 4`
DBS_DIR=${HOME}/lib-PMI-4.1.1
MPI_DIR=${DBS_DIR}
HOME_DIR=${HOME}/rmem
SCRATCH_DIR=/scratch/project_465000723/tgillis/rmem_${TAG}_${SLURM_JOBID}
export HIPCC_COMPILE_FLAGS_APPEND="--offload-arch=gfx90a $(CC --cray-print-opts=cflags)"
export HIPCC_LINK_FLAGS_APPEND=$(CC --cray-print-opts=libs)
export ASAN_OPTIONS=protect_shadow_gap=0:use_sigaltstack=0
export TSAN_OPTIONS=second_deadlock_stack=1
export FI_HMEM_CUDA_USE_GDRCOPY=1
export FI_CXI_OPTIMIZED_MRS=1
echo "--------------------------------------------------"
echo "running in ${SCRATCH_DIR}"
echo "FI_CXI_OPTIMIZED_MRS = ${FI_CXI_OPTIMIZED_MRS}"
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
for ofi_lib in 0 ; do
for cxi_disable_idc in 0 ; do
for device in 0 1; do
    export FI_CXI_DISABLE_NON_INJECT_MSG_IDC=${cxi_disable_idc}
    export USE_HIP=${device}
    make clean
    #---------------------------------------------------------------------------
    if [ ${ofi_lib} = 1 ]; then
        module unload libfabric
        export OFI_DIR=${HOME}/libfabric/_inst
        export OFI_LIB=${OFI_DIR}/lib
    else
        module load libfabric
        export OFI_DIR=/opt/cray/libfabric/1.15.2.0/
        export OFI_LIB=${OFI_DIR}/lib64
    fi
    #---------------------------------------------------------------------------
    #make info asan
    #make info verbose
    #make info fast
    make info fast
    ldd rmem
    ${HOME}/libtree/libtree rmem
    #test delivery
    declare -a test=(
        "-r am -d am -c delivery"
        "-r am -d am -c counter"
        "-r am -d tag -c fence"
        #"-r am -d tag -c delivery"
    )
    for RMEM_OPT in "${test[@]}"; do
        echo "==> ${MPI_OPT} with ${RMEM_OPT} - HIP? ${USE_HIP} - OFI? ${OFI_DIR} - DISABLE IDC? ${cxi_disable_idc}"
        FI_PROVIDER="cxi" ${MPI_DIR}/bin/mpiexec ${MPI_OPT} ./rmem ${RMEM_OPT}
    done
done
done
done
