#!/bin/bash
#FLUX: --job-name=bricky-lizard-2498
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --urgency=16

export HIPCC_COMPILE_FLAGS_APPEND='--offload-arch=gfx90a $(CC --cray-print-opts=cflags)'
export HIPCC_LINK_FLAGS_APPEND='$(CC --cray-print-opts=libs)'
export FI_HMEM_CUDA_USE_GDRCOPY='1'
export PMI_DIR='${DBS_DIR}'

echo "loading modules"
module load PrgEnv-gnu-amd
module load libfabric/1.15.2.0
module load rocm
module list
TAG=`date '+%Y-%m-%d-%H%M'`-`uuidgen -t | head -c 4`
DBS_DIR=${HOME}/.local/hydra
MPI_DIR=${DBS_DIR}
HOME_DIR=/ccs/proj/csc371/yguo/crusher/rmem/rmem-private
SCRATCH_DIR=/ccs/proj/csc371/yguo/crusher/scratch/rmem_${TAG}_${SLURM_JOBID}
export HIPCC_COMPILE_FLAGS_APPEND="--offload-arch=gfx90a $(CC --cray-print-opts=cflags)"
export HIPCC_LINK_FLAGS_APPEND=$(CC --cray-print-opts=libs)
export FI_HMEM_CUDA_USE_GDRCOPY=1
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
for device in 1; do
    export USE_HIP=${device}
    make clean ARCH_FILE=make_arch/crusher.mak
    #make info debug
    # make info debug ARCH_FILE=make_arch/crusher.mak
    # make info verbose ARCH_FILE=make_arch/crusher.mak
    make info fast ARCH_FILE=make_arch/crusher.mak
    ldd rmem
    #test delivery
    declare -a test=(
        "-r am -d am -c delivery"
        "-r am -d am -c counter"
        "-r am -d tag -c fence"
        #"-r am -d tag -c delivery"
    )
    for RMEM_OPT in "${test[@]}"; do
        echo "==> ${MPI_OPT} with ${RMEM_OPT} - HIP? ${USE_HIP}"
        FI_PROVIDER="cxi" ${MPI_DIR}/bin/mpiexec ${MPI_OPT} ./rmem ${RMEM_OPT}
        # FI_PROVIDER="cxi" srun -n2 --ntasks-per-node=1 --gpus-per-node=1 --gpu-bind=closest ./rmem ${RMEM_OPT}
    done
done
