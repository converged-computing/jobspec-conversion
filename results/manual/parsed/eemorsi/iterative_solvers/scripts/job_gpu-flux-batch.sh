#!/bin/bash
#FLUX: --job-name="ITER_SOLVERS"
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: --priority=16

export nvcudadir='$nvhome/$target/$version/cuda'
export nvcompdir='$nvhome/$target/$version/compilers'
export nvmathdir='$nvhome/$target/$version/math_libs'
export nvcommdir='$nvhome/$target/$version/comm_libs'
export NVHPC='$nvhome'
export CC='$nvcompdir/bin/nvc'
export CXX='$nvcompdir/bin/nvc++'
export FC='$nvcompdir/bin/nvfortran'
export F90='$nvcompdir/bin/nvfortran'
export F77='$nvcompdir/bin/nvfortran'
export CPP='cpp'
export OPAL_PREFIX='$nvcommdir/mpi'
export PATH='/usr/local/cuda/cuda-11.2/bin:$PATH'
export LD_LIBRARY_PATH='${HOME}/HYPRE/build_gpu/lib:${LD_LIBRARY_PATH}'
export KMP_AFFINITY='granularity=fine,compact'
export OMP_NUM_THREADS='36'
export NP='1'

nvhome=/opt/bm/nvidia/hpc_sdk
target=Linux_x86_64
version=20.9
export nvcudadir=$nvhome/$target/$version/cuda
export nvcompdir=$nvhome/$target/$version/compilers
export nvmathdir=$nvhome/$target/$version/math_libs
export nvcommdir=$nvhome/$target/$version/comm_libs
export NVHPC=$nvhome
export CC=$nvcompdir/bin/nvc
export CXX=$nvcompdir/bin/nvc++
export FC=$nvcompdir/bin/nvfortran
export F90=$nvcompdir/bin/nvfortran
export F77=$nvcompdir/bin/nvfortran
export CPP=cpp
export OPAL_PREFIX=$nvcommdir/mpi
export PATH=$nvcudadir/bin:${PATH}
export PATH=$nvcompdir/bin:${PATH}
export PATH=${OPAL_PREFIX}/bin:${PATH}
export LD_LIBRARY_PATH=$nvcudadir/lib64
export LD_LIBRARY_PATH=$nvcompdir/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=$nvmathdir/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${OPAL_PREFIX}/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=$nvcommdir/nccl/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=$nvcommdir/nvshmem/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${HOME}/HYPRE/build_gpu/lib:${LD_LIBRARY_PATH}
export PATH=/usr/local/cuda/cuda-11.2/bin:$PATH
SOLVER=12
DEBUG=0
E_MTX=1
LOG=0
P_LOG=0
PADDING=0
MTX="${HOME}/HYPRE/sim_data/${NAME}/${NAME}.mtx"
MTX_B="${HOME}/HYPRE/sim_data/${NAME}/${NAME}_b.mtx"
MTX_X="${HOME}/HYPRE/sim_data/${NAME}/${NAME}_x.mtx"
POWER="SOLVER_${SOLVER}_${NAME}.pow"
DIR="${HOME}/HYPRE/iterative_solvers"
echo "Dataset: ${NAME}"
echo "NThreads: ${NTH}"
echo "CPU INFO:"
lscpu |grep -e "Model name"
lscpu |grep -e "Socket(s):" -e "Core(s) per socket" -e "NUMA node(s):"
CMD="${DIR}/solver_gpu -solver ${SOLVER}  -log ${LOG}  -precond_log ${P_LOG}  -niter 1  -maxit 1000  -tol 1e-16  -mtx ${MTX} -p ${POWER} -id 0"
if [[ $PADDING -eq 1 ]]; then
       CMD+="  -padding"
fi
if [[ $RHS -eq 1 ]]; then
       CMD+=" -b ${MTX_B}"
fi
if [[ $X -eq 1 ]]; then
       CMD+=" -x ${MTX_X}"
fi
export KMP_AFFINITY=granularity=fine,compact
export OMP_NUM_THREADS=36
export NP=1
mpirun --mca btl '^openib' -np ${NP}  ${CMD}
exit 0
